module FipsCountyCodes
  class FipsState
    attr_reader :fips, :name

    def initialize(fips, name)
      @fips = fips
      @name = name
      @counties = {}
    end

    def []=(county_name, fips)
      @counties[county_name] = fips
    end

    def county(county_name)
      @counties[county_name]
    end

    def as_list
      @as_list ||= @counties.map{|c, f| ["#{name} - #{c} - #{f}", f] }
    end
  end
end
