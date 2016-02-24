class Location < ActiveRecord::Base
  belongs_to :locationeable, polymorphic: true
  validate :proper_address

  BAY_AREAS = ['San Francisco', 'Peninsula', 'South Bay', 'North Bay', 'East Bay']

  def proper_address
    # if somthing
    #   errors.add(:invalid_date, "the address was not found")
    # end
  end
end
