class Link < ActiveRecord::Base
  attr_accessible :text, :title, :url, :submitter_id
  validates :title, :url, :presence => true

  has_many :link_subs, :class_name => "LinkSub", :primary_key => :id,
           :foreign_key => :link_id

  has_many :subs, :through => :link_subs, :source => :sub

  has_many :comments, :class_name => "Comment", :primary_key => :id,
           :foreign_key => :link_id

  has_many :votes, :class_name => "LinkVote"

  belongs_to :submitter, :class_name => "User", :primary_key => :id,
  :foreign_key => :submitter_id

  def vote_count
    self.votes.where(:upvote => true).count - self.votes.where(:upvote => false).count
  end

  def comments_by_parent
    comments_hash = {}
    self.comments.each do |comment|
     # debugger
      comments_hash[comment.parent_comment_id.to_s] ||= []
      comments_hash[comment.parent_comment_id.to_s] << comment
    end
    comments_hash
  end
end
