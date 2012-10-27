class Activity < ActiveRecord::Base
  attr_accessible :description, :done

  has_many :spent_times, dependent: :destroy

  default_scope :order => 'created_at DESC'

  after_initialize do |activity|
    activity.description ||= ""
    activity.done ||= false
  end

  def self.executed_between(start_dt, end_dt)
    Activity.all.select do |a|
      a.spent_times.any? do |s|
        s.updated_at.between?(start_dt, end_dt)
      end
    end
  end

  def time_spent_between(start_dt, end_dt)
    times = spent_times.select do |s|
      s.updated_at.between?(start_dt, end_dt)
    end
    times.map(&:time).reduce(:+)
  end
end
