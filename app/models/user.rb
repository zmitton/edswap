class User < ActiveRecord::Base
  has_secure_password validations: false

  def create_session
    session[:user_id] = id
  end

  def email
    preferred_email || oauth_email
  end

  def verify_password
    if provider == 'edswap'
      if password.length < 6
        errors.add(:password, "Password must be at least 8 characters")
      end
    end
  end

  def self.from_omniauth(auth)
    where(auth.to_h.slice("provider", "uid")).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)

      user.oauth_email = auth.info.email
      user.save!
    end
  end

  def self.from_registration_form(user_params)
    user = User.new
    user.preferred_email = user_params[:preferred_email]
    user.password = user_params[:password]
    user.verify_password

    user.provider = "edswap"
    user.uid = nil
    user.name = ""
    user.oauth_token = nil
    user.oauth_expires_at = nil

    user.save!
    user
  end
end
