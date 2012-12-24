class User < ActiveRecord::Base
  # why get rid of?
  # attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid
  attr_accessible :blog_title

  extend FriendlyId
  friendly_id :blog_title, use: :slugged
  has_many :user_blogs
  has_many :posts
  
  validates :blog_title, :uniqueness => true

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

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)

  end
end

  # Notes
  # self.from_omniauth(auth)
  # - first_or_initialize is new method 
  #     return user record matching :provider and :uid
  #     or, initialize a new user record
  # - tap passes the user instance to the block
  # - next, set attributes provided by the hash
  # - notice we're calling methods on auth
  #     this is because oauth uses hashy gem to call methods as keys
  #     to access hash values