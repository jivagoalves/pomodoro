class Activity < ActiveRecord::Base
  attr_accessible :description, :done

  has_many :spent_times, dependent: :destroy

  default_scope :order => 'created_at DESC'

  after_initialize do |activity|
    activity.description ||= ""
    activity.done ||= false
  end

  def self.executed_at(period)
    Activity.includes(:spent_times).all.select do |a|
      a.spent_times.any? do |s|
        period.cover?(s.updated_at.to_date)
      end
    end
  end

  def time_spent_at(period)
    times = spent_times_at(period)
    times.empty? ? 0 : times.map(&:time).reduce(:+)
  end

  def time_spent_per_day_at(period)
    period.map do |day|
      time_spent_at(day..day)
    end
  end

  private

  def spent_times_at(period)
    spent_times.select do |s|
      period.cover?(s.updated_at.to_date)
    end
  end
end
