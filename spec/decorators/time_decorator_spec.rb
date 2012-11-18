require 'fast_spec_helper'
require 'time_decorator'

describe TimeDecorator do
  def time(seconds)
    TimeDecorator.new(seconds)
  end

  describe "#to_hh_mm_ss" do
    it "converts nil to '00:00:00'" do
      time(nil).to_hh_mm_ss.should == '00:00:00'
    end

    it "converts 0 secs to '00:00:00'" do
      time(0).to_hh_mm_ss.should == '00:00:00'
    end

    it "converts 30 secs to '00:00:30'" do
      time(30).to_hh_mm_ss.should == '00:00:30'
    end

    it "converts 90 secs to '00:01:30'" do
      time(90).to_hh_mm_ss.should == '00:01:30'
    end

    it "converts 3600 secs to '01:00:00'" do
      time(3600).to_hh_mm_ss.should == '01:00:00'
    end

    it "converts 3690 secs to '01:30:60'" do
      time(3690).to_hh_mm_ss.should == '01:01:30'
    end

    it "converts 3600 * 25 secs to '25:00:00'" do
      time(3600 * 25).to_hh_mm_ss.should == '25:00:00'
    end
  end

  describe "#+" do
    it "returns a decorated object" do
      (time(30) + time(20)).to_hh_mm_ss.should == '00:00:50'
    end
  end

  describe "#<=>" do
    it "compares the seconds" do
      time(10).should eq(time(10))
      time(1).should < time(2)
      time(3).should > time(2)
    end

    it "compares with numeric values" do
      time(10).should eq(10)
      time(0).should eq(0)
    end
  end
end
