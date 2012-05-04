class WeatherRequest

  def initialize(body, from_user)

    arguments = body.split(" ")
    arguments.shift

    if arguments.empty?
      @coordinates = SubscriberLocation.new.get_location from_user
    else
      @location = arguments.join(" ")
    end

  end

  def location
    @location
  end

  def coordinates
    @coordinates
  end

end