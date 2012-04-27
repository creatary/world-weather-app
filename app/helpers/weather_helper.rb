require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'google_weather.rb'

module WeatherHelper

  include DayParser

  def fetch_forecast(weather_request)

    Rails.logger.info "Fetching forecast for #{ weather_request.location} , #{weather_request.day}, #{weather_request.coordinates}"

    if weather_request.location.nil?
      weather = weather_for_coordinates(weather_request)
    else
      weather = weather_for_location(weather_request)
    end

    forecast_conditions(weather_request, weather)

  end

  def weather_for_location(weather_request)
    GoogleWeather.new(weather_request.location)
  end

  def weather_for_coordinates(weather_request)
    GoogleWeather.new(",,,#{weather_request.coordinates["latitude"]},#{weather_request.coordinates["longitude"]}")
  end

  def forecast_conditions(weather_request, weather)
    forecast = find_conditions_for_day(weather_request.day, weather)
    day_of_week =(forecast.nil?) ? normalize_day("today") : weather_request.day
    information = weather.forecast_information
    condition = find_conditions_for_day(day_of_week, weather)
    "Forecast for #{(information.city.empty?) ? "your location" : information.city} on #{condition.day_of_week}: #{condition.condition}, High: #{condition.high}F, Low: #{condition.low}F"
  end


  def find_conditions_for_day(day_of_week, weather)
    conditions = weather.forecast_conditions
    conditions.each do |condition|
      if  condition.day_of_week == day_of_week
        return condition
      end
    end
    return nil
  end
end

