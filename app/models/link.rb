class Link < ActiveRecord::Base
  attr_accessible :text, :title, :url, :submitter_id
  validates :title, :url, :presence => true

  has_many :link_subs, :class_name => "LinkSub", :primary_key => :id,
           :foreign_key => :link_id

  has_many :subs, :through => :link_subs, :source => :sub

  belongs_to :submitter, :class_name => "User", :primary_key => :id,
  :foreign_key => :submitter_id
end
