class TempEmailAddress < ActiveRecord::Base
  belongs_to :listing
  before_save :generate_temp_email_address

  def generate_temp_email_address
    temp_email_address = SecureRandom.uuid
  end
end
