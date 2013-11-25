class User < ActiveRecord::Base
	attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :provider, :uid, :oauth_token, :oauth_expires_at
	make_voter

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model

  has_many :albums, dependent: :destroy
  
  def self.from_omniauth(auth)
		  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
		    user.provider = auth.provider
		    user.uid = auth.uid
		    user.oauth_token = auth.credentials.token
		    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
		    user.email = auth.info.email
		    user.name = auth.extra.raw_info.name
		    user.save!
	  end
  end


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  user = User.where(:provider => auth.provider, :uid => auth.uid).first
  unless user
    user = User.create(name:auth.extra.raw_info.name,
                       provider:auth.provider,
                       uid:auth.uid,
                       email:auth.info.email,
                       password:Devise.friendly_token[0,20]
                       )
    	user.ensure_authentication_token!
  		end
 	 user
  end

   def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
