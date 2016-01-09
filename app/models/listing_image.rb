class ListingImage < ActiveRecord::Base
  def path
    "#{ListingImage.directory}#{filename}"
  end

  def self.directory
    "/images/uploads/"
  end

  
end
