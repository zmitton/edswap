class Location < ActiveRecord::Base
  belongs_to :locationeable, polymorphic: true
end
