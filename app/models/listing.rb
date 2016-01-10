class Listing < ActiveRecord::Base
  has_many :listing_images
  before_save :generate_temp_email

  def generate_temp_email
    temp_email = SecureRandom.uuid
  end

  def main_image
    if listing_images
      listing_images.order(:precedence).first
    else
      ListingImage.find_or_create_by(filename: 'default.png')
    end
    ListingImage.first
  end
end
