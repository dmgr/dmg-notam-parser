module Dmg
  module Notam
    module OpeningHoursParser
      VERSION = "0.0.1".freeze
      WEEKDAYS = %w[MON TUE WED THU FRI SAT SUN].map(&:freeze).freeze

      def self.parse line
        context = Context.new
        context[:opening_hours_table] = {}
        state = State::Start.new context

        line.upcase.scan(/[A-Z]+|\d{4}-\d{4}/).each do |token|
          break unless (state = state.consume_token token)
        end

        context.populate_opening_hours_table()
        context[:opening_hours_table]
      end

      class Context < Hash
        def populate_opening_hours_table
          start_weekday_idx = self.delete(State::StartWeekday)
          end_weekday_idx = self.delete(State::EndWeekday)
          opening_hours = self.delete(State::OpeningHours) # .each_slice(2).map { |opening_hours_tuple| opening_hours_tuple.join('-') }

          (start_weekday_idx .. end_weekday_idx).each do |weekday_index|
            weekday = WEEKDAYS[weekday_index]
            self[:opening_hours_table][weekday] = opening_hours
          end
        end
      end

      class State
        attr_reader :context

        def initialize context
          @context = context
        end

        def consume_token token
          next_states.each do |next_state|
            next_state = State.const_get(next_state).new(@context)
            return next_state if next_state.match token
          end

          # raise "can't find matching state for token=#{ token }) in transition #{ self.class } => #{ next_states.inspect }"

          return
        end

        class Start < State
          def next_states
            [:StartWeekday]
          end
        end

        class StartWeekday < State
          def next_states
            [:OpeningHours, :EndWeekday, :Closed]
          end

          def match token
            if weekday_index = WEEKDAYS.index(token)
              @context.populate_opening_hours_table() if @context[StartWeekday]
              @context[StartWeekday] = @context[EndWeekday] = weekday_index
            end
          end
        end

        class EndWeekday < State
          def next_states
            [:OpeningHours, :Closed]
          end

          def match token
            if weekday_index = WEEKDAYS.index(token)
              @context[EndWeekday] = weekday_index
            end
          end
        end

        class OpeningHours < State
          def next_states
            [:OpeningHours, :StartWeekday]
          end

          def match token
            (@context[OpeningHours] ||= []) << token if token =~ /\A\d{4}-\d{4}\z/
          end
        end

        class Closed < State
          def next_states
            [:StartWeekday]
          end

          def match token
            @context[OpeningHours] = ['CLOSED'] if token =~ /\ACLO?SE?D?\z/
          end
        end
      end
    end
  end
end
