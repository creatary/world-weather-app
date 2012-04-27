require 'spec_helper'

include WeatherHelper

describe WeatherHelper do
  describe "#fetch_forecast" do

    context "with missing arguments" do

      before(:each) do
        FakeWeb.register_uri(:get, "http://www.google.com/ig/api?weather=Warsaw&hl=en&oe=utf-8", :body => fixture_file("fixtures/warsaw.xml"))
        @weather_request = double("weather_request")
        @weather_request.stub(:coordinates).and_return({})
      end

      it "returns todays conditions if day without forecast specified" do

        @weather_request.stub(:location).and_return("Warsaw")
        @weather_request.stub(:day).and_return("Sun")

        fetch_forecast(@weather_request).should include "Forecast for Warsaw"
      end


      it "returns forecast conditions for specified day" do
        @weather_request.stub(:location).and_return("Warsaw")
        @weather_request.stub(:day).and_return("Thu")


        fetch_forecast(@weather_request).should include "Forecast for Warsaw"
      end

      it "returns forecast conditions with conditions, low temperature, high temperature" do

        @weather_request.stub(:location).and_return("Warsaw")
        @weather_request.stub(:day).and_return("Tue")

        forecast = fetch_forecast(@weather_request)
        forecast.should include "67"
        forecast.should include "45"
        forecast.should include "Partly Sunny"
      end

    end

    context "without location" do

      it "returns forecast conditions for coordinates" do
        FakeWeb.register_uri(:get, "http://www.google.com/ig/api?hl=en&oe=utf-8&weather=%2C%2C%2C32221700%2C110925800", :body => fixture_file("fixtures/coords.xml"))
        @weather_request = double("weather_request")
        @weather_request.stub(:location).and_return(nil)
        @weather_request.stub(:day).and_return("Fri")
        @weather_request.stub(:coordinates).and_return({"latitude" => "32221700", "longitude" => "110925800"})

        fetch_forecast(@weather_request).should include "Forecast for your location"
      end

    end

  end

end