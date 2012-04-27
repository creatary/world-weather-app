include DayParser
include CoordinatesParser

class WeatherRequest

  def initialize(body, from_user)

    arguments = body.split(" ")

    if arguments.size==1
      @coordinates = normalize Creatary::API.getcoord(from_user)["body"]
    elsif arguments.size==2
      @day = normalize_day(arguments[1])
      if @day.nil?
        @location = arguments[1]
      else
        @coordinates = normalize Creatary::API.getcoord(from_user)["body"]
      end

    elsif arguments.size==3
      @location = arguments[1]
      @day = normalize_day(arguments[2])
    end

  end

  def day
    (@day.nil?) ? normalize_day("today") : @day
  end

  def location
    @location
  end

  def coordinates
    @coordinates
  end

end