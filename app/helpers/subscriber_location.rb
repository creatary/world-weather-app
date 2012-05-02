include CoordinatesParser

class SubscriberLocation
 def get_location(from_user)
   normalize Creatary::API.getcoord(from_user)["body"]
 end
end