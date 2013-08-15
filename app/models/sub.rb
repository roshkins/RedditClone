class Sub < ActiveRecord::Base
  attr_accessible :moderator_id, :name

  validates :moderator_id, :name, :presence => true

  has_many :link_subs, :class_name => "LinkSub", :primary_key => :id,
           :foreign_key => :sub_id

  has_many :links, :through => :link_subs, :source => :link

  belongs_to :moderator, :class_name => "User", :primary_key => :id,
             :foreign_key => :moderator_id
end
