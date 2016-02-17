require 'dmg/notam/opening_hours_parser'

RSpec.describe Dmg::Notam::OpeningHoursParser do
  describe '#parse' do
    it "parses opening hours" do
      examples = [
        {
          input: "MON-WED 0500-1830 THU 0500-2130 FRI 0730-2100 SAT 0630-0730, 1900-2100 SUN CLOSE",
          output: {
            'MON' => ['0500-1830'],
            'TUE' => ['0500-1830'],
            'WED' => ['0500-1830'],
            'THU' => ['0500-2130'],
            'FRI' => ['0730-2100'],
            'SAT' => ['0630-0730', '1900-2100'],
            'SUN' => ['CLOSED'],
          }
        },
        {
          input: "MON 0500-2000 TUE-THU 0500-2100 FRI 0545-2100 SAT0630-0730 1900-2100 SUN CLOSED CREATED:",
          output: {
            'MON' => ['0500-2000'],
            'TUE' => ['0500-2100'],
            'WED' => ['0500-2100'],
            'THU' => ['0500-2100'],
            'FRI' => ['0545-2100'],
            'SAT' => ['0630-0730', '1900-2100'],
            'SUN' => ['CLOSED'],
          }
        }
      ]

      examples.each do |example|
        result = Dmg::Notam::OpeningHoursParser.parse example[:input]
        expect(result).to eq example[:output]
      end
    end
  end
end
