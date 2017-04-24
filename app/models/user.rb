class User < ApplicationRecord
  attr_reader :password

  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many :subs,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Sub

  has_many :posts,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Post

  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def self.find_by_credentials(options = {})
    username = options[:username]
    password = options[:password]
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def reset_session_token
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
