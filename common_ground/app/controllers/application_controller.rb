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
  def rank(locations, center, userList)
    @points = []
    locations.each do |location|
      @points.push({"id" => location.id, "lat" => location.lat, "lng" => location.lng})
    end

    #Compute time from each user to all points
    userList.each do |user|
      if user.latitude && user.longitude
        request = {
            "format" => "json",
            "api_id" => API_ID,
            "api_key" => API_KEY,
            "origin" => { "lat" => user.latitude, "lng" => user.longitude },
            "travel_time" => "36000",
            "mode" => "driving",
            "points" => @points
          }.to_json
        url = 'http://api.igeolise.com/time_filter'
        user.times = ActiveSupport::JSON.decode(RestClient.post(url, request, :content_type => :json, :accept => :json))
        user.times.each do |result|
          @points.select { |p| p["id"] = result.id }.totalTime += result.time
        end
      else
        user.times = [];
      end
    end

    #Compute average time to each point
    @points.each do |point|
      point.averageTime = point.time / userList.count
    end

    #Compute sum of squares of the difference of usertime and averagetime
    @points.each do |point|
     @userList.each do |user|
       timeForUser = user.times.select { |p| p["id"] = point.id}.time
       point.totalSquareTime += (timeForUser - point.averageTime)^2
     end
    end


    #Maybe check if place is open using google api?

    #Sort points by min totalSquareTime
    @points.sort! { |a,b| a.totalSquareTime <=> b.totalSquareTime }
  end
end
