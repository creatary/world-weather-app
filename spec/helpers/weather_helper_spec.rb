require 'spec_helper'

include WeatherHelper

describe WeatherHelper do
  describe "#fetch_forecast" do

      it "returns forecast conditions with conditions, low temperature, high temperature" do
        FakeWeb.register_uri(:get, "http://www.google.com/ig/api?weather=Warsaw&hl=en&oe=utf-8", :body => fixture_file("fixtures/warsaw.xml"))
        @weather_request = double("weather_request")
        @weather_request.stub(:coordinates).and_return({})
        @weather_request.stub(:location).and_return("Warsaw")

        forecast = fetch_forecast(@weather_request)
        forecast.should include "19"
        forecast.should include "7"
        forecast.should include "Partly Sunny"
      end

      it "returns forecast conditions for coordinates" do
        FakeWeb.register_uri(:get, "http://www.google.com/ig/api?hl=en&oe=utf-8&weather=%2C%2C%2C32221700%2C110925800", :body => fixture_file("fixtures/coords.xml"))
        @weather_request = double("weather_request")
        @weather_request.stub(:location).and_return(nil)
        @weather_request.stub(:coordinates).and_return({"latitude" => "32221700", "longitude" => "110925800"})

        fetch_forecast(@weather_request).should include "Your location"
      end

      it "returns error message for wrong location" do
        FakeWeb.register_uri(:get, "http://www.google.com/ig/api?weather=NoExistingCity&hl=en&oe=utf-8", :body => fixture_file("fixtures/error.xml"))
        @weather_request = double("weather_request")
        @weather_request.stub(:location).and_return("NoExistingCity")
        @weather_request.stub(:coordinates).and_return({})

        fetch_forecast(@weather_request).should include "No weather information for NoExistingCity"
      end

  end

end