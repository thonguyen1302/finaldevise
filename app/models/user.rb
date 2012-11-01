class User < ActiveRecord::Base
  has_many :authorizations
  #validates :name, :presence => true
  has_many :order
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
 # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :omniauthable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:first_name, :last_name, :birthday, :phone_number, :name, :provider, :status
  # attr_accessible :title, :body
  validates :email, :password, :password_confirmation, :first_name, :last_name, :birthday, :phone_number, presence: true
  validates :phone_number, numericality: {}
  validates_uniqueness_of :email


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.email = auth.info.email
      user.password = "sa"
      user.password_confirmation = "sa"
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.birthday = "2012-10-26 09:20:19"
      user.phone_number = '0912093'
      user.save!
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  
def add_provider(auth_hash)
  # Check if the provider already exists, so we don't add it twice
  unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
  end
end


  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil
  end
  
  def friends_count
    facebook { |fb| fb.get_connection("me", "friends").size }

  end

  def post_to_wall(status)
    facebook { |fb| fb.put_wall_post(status) }

  end

  def list_friends
    facebook { |fb| fb.get_connection("me","friends")}

  end

  

end
