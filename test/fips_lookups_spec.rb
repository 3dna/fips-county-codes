require_relative 'helper'

describe 'Mapping (State, County) between (NISTCodes Code)' do

  it 'looks up a fips for a state and county' do
    FipsCountyCodes::FIPS['CA']['Los Angeles'].should == "06037"
    FipsCountyCodes::FIPS['CA']['Los Angeles County'].should == "06037"
  end

  it 'looks up a state and county' do
    FipsCountyCodes::STATE_COUNTY["06037"].should == ['CA', 'Los Angeles County']
  end

  it "looks up codes from a frozen hash" do
    FipsCountyCodes::FIPS.frozen?.should be_true
    FipsCountyCodes::STATE_COUNTY.frozen?.should be_true
  end

  it "has an entry for each state scoped to all counties" do
      FipsCountyCodes::STATE_COUNTY["06000"].should == ['CA', 'All Counties']
  end

end
