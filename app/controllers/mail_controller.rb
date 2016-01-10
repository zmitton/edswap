class MailController < ApplicationController
  respond_to :xml
  def parse
    ListingImage.create
    # redirect_to '/'
  end
end
