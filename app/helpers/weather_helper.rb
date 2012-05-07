require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'google_weather.rb'
module WeatherHelper
  SMS_LENGHT = 160

  def fetch_forecast(weather_request)

    Rails.logger.info "Fetching forecast for #{ weather_request.location}, #{weather_request.coordinates}"

    if weather_request.location.nil?
      weather = weather_for_coordinates(weather_request)
    else
      weather = weather_for_location(weather_request)
    end

    forecast_conditions(weather)

  end

  def weather_for_location(weather_request)
    GoogleWeather.new(weather_request.location)
  end

  def weather_for_coordinates(weather_request)
    GoogleWeather.new(",,,#{weather_request.coordinates["latitude"]},#{weather_request.coordinates["longitude"]}")
  end


  def forecast_conditions(weather)

    information = weather.forecast_information
    result = "#{(information.city.empty?) ? "Your location" : information.city.split(",").shift} "

    weather.forecast_conditions.each do |condition|
      string = " #{condition.day_of_week}:#{condition.condition}, #{condition.high.in_celcius}/#{condition.low.in_celcius}C"
      if result.length + string.length < SMS_LENGHT
        result.concat string
      end
    end

    result
  end
end

class String

  def in_celcius()
    ((self.to_f-32)*(5.0/9)).round.to_s
  end

end

