class LinkSub < ActiveRecord::Base
  attr_accessible :link_id, :sub_id

  belongs_to :link, :class_name => "Link", :primary_key => :id,
             :foreign_key => :link_id
  belongs_to :sub, :class_name => "Sub", :primary_key => :id,
             :foreign_key => :sub_id
end
