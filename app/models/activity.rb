class Activity < ActiveRecord::Base
  attr_accessible :description, :done

  has_many :spent_times, dependent: :destroy

  default_scope :order => 'updated_at DESC'

  after_initialize do |activity|
    activity.description ||= ""
    activity.done ||= false
  end

  def self.ordered_by_most_active
    # TODO: Optimize this method
    # TODO: Also check others
    self.all.sort do |a,b|
      b.activeness <=> a.activeness
    end
  end

  def self.executed_at(period)
    self.includes(:spent_times).all.select do |a|
      a.spent_times.any? do |s|
        period.cover?(s.updated_at.to_date)
      end
    end
  end

  def activeness
    last_execution_at ? last_execution_at : updated_at
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

  def last_execution_at
    last_spent_time && last_spent_time.updated_at
  end

  private

  def spent_times_at(period)
    spent_times.select do |s|
      period.cover?(s.updated_at.to_date)
    end
  end

  def last_spent_time
    spent_times.last_updated
  end
end
