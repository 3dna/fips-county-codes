require 'csv'
require_relative 'fips_code'
require_relative 'fips_state'

module FipsCountyCodes

  FIPS = {}
  STATE_COUNTY = {}

  def self.fips(county_code)
    return STATE_COUNTY[county_code] if STATE_COUNTY.has_key? county_code
    FipsCode.new("", "")
  end

  def self.state(state)
    return FIPS[state] if FIPS.has_key? state
    FipsState.new("", "")
  end

  def self.as_list
    @@as_list ||= FIPS.values.map{|state| state.as_list}.flatten
  end

  def self.load_fips_data
    data = CSV.read(File.join(File.expand_path(File.dirname(__FILE__)), 'national.txt'))
    data.shift

    data.each do |row|
      state, state_code, county_code, county, class_code_ignored = row.to_a
      long_state_code = "#{state_code}000"
      fips_code = "#{state_code}#{county_code}"

      unless FIPS.has_key? state
        FIPS[state] = FipsState.new(long_state_code, state)
        STATE_COUNTY[long_state_code] = FipsCode.new(state, "All Counties")
      end

      FIPS[state][county] = fips_code
      county2 = county.gsub(' County', '')
      FIPS[state][county2] = fips_code if county != county2
      STATE_COUNTY[fips_code] = FipsCode.new(state, county)
    end
    FIPS.freeze
    STATE_COUNTY.freeze
    as_list
  end

  self.load_fips_data
end
