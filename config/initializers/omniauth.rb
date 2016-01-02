OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['EDSWAP_FACEBOOK_APP_ID'], ENV['EDSWAP_FACEBOOK_APP_SECRET'], {:scope => 'email,public_profile,user_friends,user_education_history', :info_fields => 'email', :client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['EDSWAP_GOOGLE_CLIENT_ID'], ENV['EDSWAP_GOOGLE_CLIENT_SECRET'], {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
