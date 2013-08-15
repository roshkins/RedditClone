require 'bcrypt'
class User < ActiveRecord::Base
  attr_accessible :password_digest, :username, :password, :session_token

  validates :username, :password_digest, :presence => true

  def password=(plaintext)
    unless plaintext.blank? || plaintext.length < 6
      self.password_digest = BCrypt::Password.create(plaintext)
    else
      self.errors.add(:password,
       "must be 6 or more characters long and not blank.")
       self.password_digest = nil
    end
  end

  def is_authenticated?(password)
    BCrypt::Password.new(self.password_digest) == password
  end

  def create_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
end
