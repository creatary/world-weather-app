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

      it "returns parsed today" do
        @weather_request.day.should == @time.strftime("%a")
      end

    end

    #context "when only day is specified" do
    #
    #  before :each do
    #    @body="weather tue"
    #    @from_user=nil
    #    @subscriber_location = double("subscriber_location")
    #    @subscriber_location.stub(:get_location).and_return({})
    #
    #    @weather_request = WeatherRequest.new(@body,@from_user)
    #  end
    #
    #  it "returns coordinates" do
    #    @weather_request.coordinates.should_not be_nil
    #  end
    #
    #  it "returns parsed day" do
    #    @weather_request.day.should == "Tue"
    #
    #  end
    #
    #end
    #
    #context "when no arguments specified" do
    #  it "returns coordinates and parsed today" do
    #    @body="weather"
    #
    #  end
    #
    #end

  end


end