class MailController < ApplicationController
  skip_before_action :verify_authenticity_token
  def route
    # message = Message.new(
    #   :to => params[:envelope][:to],
    #   :from => params[:envelope][:from],
    #   :subject => params[:headers]['Subject'],
    #   :body => params[:plain]
    # )

    # to_temp_address = TempEmailAddress.find_by_temp_email_address(destination_code)
    # if to_temp_address && to_temp_address.listing.active
      # from_temp_address = TempEmailAddress.find_or_create_by(listing_id: to_temp_address.listing_id, real_email_address: from)
      UserMailer.listing_reply(params, "to_temp_address", "from_temp_address").deliver_now
      render :text => 'Success', :status => 200
    # else
    #   render :text => "temp_email_address_not_found", :status => 422, :content_type => Mime::TEXT.to_s
    # end
  end

  private

  def destination_code
    params[:envelope]['To'].split("@").first
  end

  def from
    params[:envelope][:from]
  end

end
