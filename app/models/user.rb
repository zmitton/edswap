class User < ActiveRecord::Base
  has_secure_password validations: false
  validate :unique_email

  def unique_email
    if !User.where.not(id: id).where(provider: 'edswap', preferred_email: preferred_email).blank?
      errors.add(:email, 'address already registered')
    end
  end

  def preferred_contact
    email || nil
  end

  def nickname
    name == "" || name.nil? ? email : name
  end

  def email
    preferred_email || oauth_email
  end

  def verify_password
    if provider != 'facebook' && provider != 'google_oauth2'
      if !password || password.length < 6
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
      user.save
    end
  end

  def self.from_login_form(user_params)
    user = User.new(preferred_email: user_params[:preferred_email], provider: 'edswap')
    temp_user = find_by(preferred_email: user_params[:preferred_email], provider: 'edswap')
    if temp_user
      if temp_user.authenticate(user_params[:password])
        user = temp_user
      else
        user.errors.add(:forbidden, 'password incorrect')
      end
    else
      user.errors.add(:not_found, 'email not found in our system')
    end
    user
  end

  def self.register(user_params)
    user = User.new
    user.preferred_email = user_params[:preferred_email]
    user.password = user_params[:password]
    user.provider = "edswap"
    user.verify_password

    user.uid = nil
    user.name = user_params[:name]
    user.oauth_token = nil
    user.oauth_expires_at = nil
    user
  end
end
