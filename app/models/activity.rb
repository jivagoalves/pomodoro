class Activity < ActiveRecord::Base
  attr_accessible :description, :done
  default_scope :order => 'created_at DESC'

  after_initialize do |activity|
    activity.description ||= ""
    activity.done ||= false
  end
end
