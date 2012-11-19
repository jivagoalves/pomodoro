require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/array/access'
require 'delegate'

class TimeDecorator < SimpleDelegator
  include Comparable

  def initialize(time)
    @time = time
    super(@time)
  end

  def to_hh_mm_ss
    return "00:00:00" unless @time.present?
    ss = fulfill_with_zero(seconds)
    mm = fulfill_with_zero(minutes)
    hh = fulfill_with_zero(hours)
    "#{hh}:#{mm}:#{ss}"
  end

  def +(other)
    self.class.new(time + other.time)
  end

  def <=>(other)
    other.is_a?(self.class) ? time <=> other.time : time <=> other
  end

  protected

  def time
    @time
  end

  private

  def seconds
    @time.divmod(60).second
  end

  def minutes
    mm, ss = @time.divmod(60)
    mm.divmod(60).second
  end

  def hours
    mm, ss = @time.divmod(60)
    mm.divmod(60).first
  end

  def fulfill_with_zero(number)
    number < 10 ? "0#{number}" : number
  end
end
