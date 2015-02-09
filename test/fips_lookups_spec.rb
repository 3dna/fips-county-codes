require_relative "helper"

describe "Mapping (State, County) between (NISTCodes Code)" do

  it "looks up a fips for a state and county" do
    FipsCountyCodes.state("CA").county("Los Angeles").should == "06037"
    FipsCountyCodes.state("CA").county("Los Angeles County").should == "06037"
    FipsCountyCodes.state("CA").fips.should == "06000"
    FipsCountyCodes.state("CA").counties.count.should == 116 # should include 06000 all counties?
  end

  it "looks up a state and county" do
    FipsCountyCodes.fips("06037").state.should == "CA"
    FipsCountyCodes.fips("06037").county.should == "Los Angeles County"
    FipsCountyCodes.fips("06037").to_a.should == ["CA", "Los Angeles County"]
  end

  it "looks for a fips that does not exist" do
    FipsCountyCodes.fips("99999").state.should == ""
    FipsCountyCodes.fips("99999").county.should == ""
    FipsCountyCodes.fips("99999").to_a.should == ["", ""]
  end

  it "looks up codes from a frozen hash" do
    FipsCountyCodes::FIPS.frozen?.should be_true
    FipsCountyCodes::STATE_COUNTY.frozen?.should be_true
  end

  it "returns frozen arrays" do
    FipsCountyCodes.fips("06037").to_a.frozen?.should be_true
    FipsCountyCodes.fips("06000").to_a.frozen?.should be_true
  end

  it "has an entry for each state scoped to all counties" do
    FipsCountyCodes.fips("06000").to_a.should == ["CA", "All Counties"]
  end

end
