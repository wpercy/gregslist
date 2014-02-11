class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :PMs, dependent: :destroy
  has_one :ApiKey, dependent: :destroy

  has_many :PMs, dependent: :destroy
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  serialize :favorites

  before_save { self.email = email.downcase }

  before_create :create_remember_token

  before_create { self.favorites = [] }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def pms
    Pm.where("recipient_id=?", id)
  end

  def favorites_feed
    Micropost.from_favorites(self)
  end

  def recents_feed
    Micropost.recents(self)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

    def create_api_key
      ApiKey.create(user_id: params[:id])
    end
end
