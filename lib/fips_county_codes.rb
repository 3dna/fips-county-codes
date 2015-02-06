module FipsCountyCodes
  fips = {}
  state_county = {}

  LIB_DIRECTORY = File.expand_path(File.dirname(__FILE__))
  FIPS_CODES_CSV_FILE = File.join(LIB_DIRECTORY, 'national.txt')

  File.open(FIPS_CODES_CSV_FILE) do |f|
    f.readline # skip the first line with headers

    until f.eof
      row = f.readline.chomp.split(',')
      state, state_code, county_code, county, class_code_ignored = row

      fips[state] = {} if not fips.member?(state)

      fips_code = "#{state_code}#{county_code}"
      fips[state][county] = fips_code

      county2 = county.gsub(' County', '')
      fips[state][county2] = fips_code if county != county2

      state_county[fips_code] = [state, county]
    end
  end

  FIPS = fips.freeze
  STATE_COUNTY = state_county.freeze
end

