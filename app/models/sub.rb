class Sub < ActiveRecord::Base
  attr_accessible :moderator_id, :name

  validates :moderator_id, :name, :presence => true
end
