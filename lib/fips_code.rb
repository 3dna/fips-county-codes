module FipsCountyCodes
  class FipsCode
    attr_reader :state, :county

    def initialize(state, county)
      @state = state
      @county = county
    end

    def to_a
      [state, county].freeze
    end
  end
end
