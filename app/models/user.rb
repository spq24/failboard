class User < ActiveRecord::Base
	attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :provider, :uid, :oauth_token, :oauth_expires_at
	make_voter

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:recoverable
         :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model


  has_many :fails, dependent: :destroy

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  user = User.where(:provider => auth.provider, :uid => auth.uid).first
  unless user
    user = User.create(name:auth.extra.raw_info.name,
                       provider:auth.provider,
                       uid:auth.uid,
                       email:auth.info.email,
                       password:Devise.friendly_token[0,20]
                       )
  		end
 	 user.save
  end

   def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
		where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
		user.provider = auth.provider
		user.uid = auth.uid
		user.email = auth.info.email
		user.encrypted_password = Devise.friendly_token[0,20]
		user.name = auth.extra.raw_info.name
		user.save!
	end
  end

end
