class ApplicationController < ActionController::Base
  protect_from_forgery

  def getCentroid(userList)
    @count = 0
    @lats = 0
    @longs = 0
    userList.each do |user|
      if user.latitude and user.longitude
        @count += 1
        @lats += user.latitude
        @longs += user.longitude
      end
    end

    if @count > 0 
      return [@lats/@count, @longs/@count]
    end
  end

  # Locations are in the form of [lat,long]
  def rank(locations)

  end
end
