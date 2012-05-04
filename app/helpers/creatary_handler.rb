#
# Copyright 2012 Nokia Siemens Networks 
#
class CreataryHandler

  include WeatherHelper

  def receive_sms(from_user, to_app, body, transaction_id)

    weather_request = WeatherRequest.new body, from_user
    response = fetch_forecast weather_request

    Rails.logger.info "Sending response... #{response} to request #{body}"

    Creatary::API.send_sms(to_app, from_user, response, transaction_id)

    log_request(body, from_user, response, weather_request)

  end

  def log_request(body, from_user, response, weather_request)
    Rails.logger.info "Sending response... #{response} to request #{body}"
    file = File.open("db/received_sms.txt", "w+")
    file.puts("Request: #{body} #{from_user.token_secret} #{from_user.access_token}, Coords: #{weather_request.coordinates}, Response: #{response}")
    file.close
  end

  def self.last_call
    #if File.exists?("db/received_sms.txt")
    #  file = File.open("db/received_sms.txt", "r")
    #  sms = file.readline
    #  file.close
    #  sms
    #end
  end

end
