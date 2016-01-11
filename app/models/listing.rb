class Listing < ActiveRecord::Base
  has_many :listing_images
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  after_save :generate_temp_email

  def generate_temp_email
    TempEmailAddress.find_or_create_by(listing_id: id, real_email_address: author.email)
  end

  def main_image
    # if listing_images
    #   listing_images.order(:precedence).first
    # else
    #   ListingImage.find_or_create_by(filename: 'default.png')
    # end
    # ListingImage.first
    "sample.jpg"
  end
end
