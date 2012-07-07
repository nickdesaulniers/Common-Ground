class User < ActiveRecord::Base
  attr_accessible :email, :latitude, :longitude
  belongs_to :room
end
