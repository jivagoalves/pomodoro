require 'delegate'

class DateRange < SimpleDelegator
  def initialize(start_date, end_date)
    @start_date, @end_date = start_date, end_date
    super(range)
  end

  private

  def range
    @start_date..@end_date
  end
end
