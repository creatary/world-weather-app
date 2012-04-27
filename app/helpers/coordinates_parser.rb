module CoordinatesParser

  def normalize (coordinates)
    latitude = format_coords coordinates["latitude"].to_s
    longitude = format_coords coordinates["longitude"].to_s

    {"latitude"=>latitude, "longitude"=>longitude}

  end

  def format_coords(value)
    value = ("%-8d" % [value.gsub!('.', '')]).gsub!(" ","0")
    value.index('-') != -1 ? value.slice!(0, 9) : value.slice!(0, 8)
  end

end