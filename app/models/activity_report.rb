require 'date/date_range'

class ActivityReport
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :start_date, :end_date

  def persisted?
    false
  end

  def initialize(attrs = {})
    attrs ||= {}
    default_attrs.merge(attrs).each do |attr, value|
      send("#{attr}=", value) unless attr =~ /date/
    end
    assign_date_attributes(attrs)
    load_activities_with_time_spent
  end

  def each_with_times(&block)
    @activities.each do |a|
      yield(a, @report[a.id])
    end
  end

  def map_with_times(&block)
    @activities.map do |a|
      yield(a, @report[a.id])
    end
  end

  def period
    DateRange.new(start_date, end_date)
  end

  private

  def default_attrs
    {
      start_date: Date.today,
      end_date: Date.today
    }
  end

  def load_activities_with_time_spent
    @activities = Activity.executed_at(period)
    @report = @activities.each_with_object({}) do |a, r|
      r[a.id] = a.time_spent_per_day_at(period).map do |time|
        TimeDecorator.new(time)
      end
    end
  end

  def assign_date_attributes(attrs)
    default_attrs.each do |k,v|
      send("#{k}=",v)
    end
    [:start_date, :end_date].each do |attr|
      send("#{attr}=", Date.new(
        attrs["#{attr}(1i)"].to_i,
        attrs["#{attr}(2i)"].to_i,
        attrs["#{attr}(3i)"].to_i
      )) unless attrs["#{attr}(1i)"].nil?
    end
  end
end
