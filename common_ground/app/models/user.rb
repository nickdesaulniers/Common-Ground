class User < ActiveRecord::Base
  attr_accessible :email, :latitude, :longitude
end
