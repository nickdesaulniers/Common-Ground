class Room < ActiveRecord::Base
  attr_accessible :name, :members
  has_many :users
end
