require 'dmg/notam/opening_hours_parser'

module Dmg
  module Notam
    class Record
      def initialize raw
        @raw = raw.gsub(/\n+\s*/m, ' ')
      end

      def icao_code
        # A) ESGJ
        @raw[/A\) ?([A-Z]+)/, 1]
      end

      def opening_hours
        if opening_hours = @raw[%r{E\) ?AERODROME HOURS OF OPS/SERVICE (.+)}, 1]
          OpeningHoursParser.parse opening_hours
        end
      end
    end
  end
end
