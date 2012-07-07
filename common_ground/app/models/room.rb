class Room < ActiveRecord::Base
  attr_accessible :name, :members
end
