require 'bcrypt'
class User < ActiveRecord::Base
  attr_accessible :password_digest, :username, :password, :session_token

  validates :username, :password_digest, :presence => true

  has_many :subs, :class_name => "Sub",  :primary_key => :id,
             :foreign_key => :moderator_id

  has_many :links, :class_name => "Link", :primary_key => :id,
           :foreign_key => :submitter_id

  has_many :comments, :class_name => "Comment", :primary_key => :id,
           :foreign_key => :author_id

  has_many :votes, :class_name => "LinkVote"

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

  def vote(link_vote)
    unless self.votes.find_by_user_id_and_link_id(link_vote.user_id,
           link_vote.link_id)
      self.votes << link_vote
      link_vote.save!
      self.save!
    else
      old_link_vote = self.votes.find_by_link_id(link_vote.link_id)
      if old_link_vote && old_link_vote.upvote == link_vote.upvote
        old_link_vote.destroy
      else
        old_link_vote.destroy
        self.votes << link_vote
        self.save!
        link_vote.save!
      end
    end
  end

end
