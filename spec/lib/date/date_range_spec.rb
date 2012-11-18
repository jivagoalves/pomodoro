require 'fast_spec_helper'
require 'date/date_range'
require 'active_support/core_ext/date/acts_like'
require 'active_support/core_ext/date/calculations'
require 'active_support/core_ext/numeric/time'

describe DateRange do
  describe "#cover?(date)" do
    context "when date is within the range" do
      it "returns true" do
        range = DateRange.new(Date.yesterday, Date.tomorrow)
        range.should cover(Date.yesterday)
        range.should cover(Date.today)
        range.should cover(Date.tomorrow)
      end
    end

    context "when date is *not* within the range" do
      it "returns false" do
        range = DateRange.new(Date.today, Date.tomorrow)
        range.should_not cover(Date.yesterday)
        range.should_not cover(Date.tomorrow + 1.day)
      end
    end
  end

  describe "#each" do
    it "iterates the range" do
      range = DateRange.new(Date.yesterday, Date.tomorrow)
      count = range.each.inject(0){|cnt, _| cnt += 1 }
      count.should == 3
    end
  end
end
