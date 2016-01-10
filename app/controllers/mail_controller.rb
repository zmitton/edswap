class ListingsController < ApplicationController
  def parse
    ListingImage.create
  end
end
