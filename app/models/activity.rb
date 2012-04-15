class Activity < ActiveRecord::Base
  attr_accessible :description, :done

  after_initialize do |activity|
    activity.description ||= ""
    activity.done ||= false
  end
end
