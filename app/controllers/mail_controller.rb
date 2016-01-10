class MailController < ApplicationController
  def parse
    ListingImage.create
    redirect_to '/'
  end
end
