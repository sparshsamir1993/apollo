class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :authorizations
  validates :name, :email, :presence => true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable, :omniauth_providers => [:facebook]

  #def add_provider(auth_hash)
  # Check if the provider already exists, so we don't add it twice
  #unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  #  Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
  #end
#end
#def failure
#  render :text => "Sorry, but you didn't allow access to our app!"
#end
#def destroy
#  session[:user_id] = nil
#  render :text => "You've logged out!"
#end

def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!
  end
end
def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
