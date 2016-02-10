class Listing < ActiveRecord::Base
  has_many :listing_images
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  after_save :generate_temp_email
  validates_presence_of :subject
  validates_presence_of :body

  has_one :location, as: :locationeable

  INTENTIONS = [:buying, :selling, :lending, :trading, :borrowing]

  def generate_temp_email
    TempEmailAddress.find_or_create_by(listing_id: id, real_email_address: author.email)
  end

  def main_image_path
    if listing_images.any?
      listing_images.order(:precedence).first.image_path
    else
      "supplies.jpg"
    end
  end

  def has_image?
    @has_image ||= listing_images.any?
  end

  def location
    Location.find_by_belongs_to_id(id) || author.location
  end

  def intensions
    Listing::INTENTIONS.select {|intention| self.send(intention)}
  end

  def temp_email_address
    TempEmailAddress.find_by(listing_id: self.id, real_email_address: author.preferred_email)
  end
end
