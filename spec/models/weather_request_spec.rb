require 'spec_helper'

describe WeatherRequest do

  context "creating" do
    context "when only location is specified" do

      before :each do
        @time = Time.new
        Time.stub!(:now).and_return(@time)
        @body="weather Warsaw"
        @from_user=nil
        @weather_request = WeatherRequest.new(@body,@from_user)
      end

      it "returns location" do
        @weather_request.location.should == "Warsaw"
      end

    end

  end

end