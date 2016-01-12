class Location < ActiveRecord::Base
  belongs_to :locationeable, polymorphic: true
  validates_presence_of :zip
end
