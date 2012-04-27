module DayParser

  DAYS_MAP = {
      "monday" => "Mon",
      "mon" => "Mon",
      "tuesday" => "Tue",
      "tue" => "Tue",
      "tues" => "Tue",
      "wed" => "Wed",
      "wednesday" => "Wed",
      "thurs" => "Thu",
      "thu" => "Thu",
      "thursday" => "Thu",
      "friday" => "Fri",
      "fri" => "Fri",
      "saturday" => "Sat",
      "sat" => "Sat",
      "sunday" => "Sun",
      "sun" => "Sun",
  }

  def normalize_day(day)
    if day.nil? || day.downcase == "today"
      return Time.now.strftime("%a")
    end

    if day.downcase == "tomorrow"
      return Time.tomorow.strftime("%a")
    end

    if DAYS_MAP.has_key?(day.downcase)
       DAYS_MAP[day.downcase]
    end

  end
end
