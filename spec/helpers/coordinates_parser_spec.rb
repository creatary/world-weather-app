require 'spec_helper'

include CoordinatesParser

describe CoordinatesParser do
  describe "#normalize" do

    context "for positive values input" do

      before do
        @coords={"latitude"=>30.0, "longitude"=>90.0, "accuracy"=>10, "timestamp"=>1335359566744}
      end

      it "returns latitude in 8 characters format trailed by zeros" do
        normalize(@coords)["latitude"].should == "30000000"
      end

      it "returns longitude in 8 characters format trailed by zeros" do
        normalize(@coords)["longitude"].should == "90000000"
      end

    end

    context "for negative values input" do

      before do
        @coords={"latitude"=>6.7163, "longitude"=>-16.1865, "accuracy"=>10, "timestamp"=>1335359566744}
      end

      it "returns longitude in 7 characters format trailed by zeros with leading minus" do
        normalize(@coords)["longitude"].should == "-1618650"
      end

    end

  end

end