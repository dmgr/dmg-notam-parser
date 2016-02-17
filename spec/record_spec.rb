require 'dmg/notam/record'

RSpec.describe Dmg::Notam::Record do
  describe '#icao_code' do
    it "parses ICAO code" do
      { 1 => 'ESGJ', 2 => 'ESGJ' }.each do |i, icao_code|
        notam_raw_text = File.read("fixtures/notam#{ i }.txt")
        notam_record = Dmg::Notam::Record.new notam_raw_text
        expect(notam_record.icao_code).to eq icao_code
      end
    end
  end

  describe '#opening_hours' do
    it "parses opening hours" do
      examples = {
        1 => {
          'MON' => ['0500-1830'],
          'TUE' => ['0500-1830'],
          'WED' => ['0500-1830'],
          'THU' => ['0500-2130'],
          'FRI' => ['0730-2100'],
          'SAT' => ['0630-0730', '1900-2100'],
          'SUN' => ['CLOSED'],
        },
        2 => {
          'MON' => ['0500-2000'],
          'TUE' => ['0500-2100'],
          'WED' => ['0500-2100'],
          'THU' => ['0500-2100'],
          'FRI' => ['0545-2100'],
          'SAT' => ['0630-0730', '1900-2100'],
          'SUN' => ['CLOSED'],
        }
      }

      examples.each do |i, output|
        notam_raw_text = File.read("fixtures/notam#{ i }.txt")
        notam_record = Dmg::Notam::Record.new notam_raw_text
        expect(notam_record.opening_hours).to eq output
      end
    end
  end
end