require 'spec_helper'

describe SpentTime do
  context "after initialization" do
    its(:time) { should == 0 }
  end

  context "without activity" do
    it { should_not be_valid }
  end

  describe ".updated_today" do
    let(:activity) { Activity.create! }

    before do
      SpentTime.new do |s|
        s.updated_at = Time.now - 1.day
        s.activity = activity
        s.time = 10
        s.save!
      end

      SpentTime.new do |s|
        s.updated_at = Time.now
        s.activity = activity
        s.time = 20
        s.save!
      end
    end

    it "returns only the ones updated today" do
      SpentTime.updated_today.tap do |ary|
        ary.should have(1).element
        ary.map(&:time).should include(20)
      end
    end
  end

  describe ".last_updated" do
    before do
      Activity.create! do |a|
        [5, 10].each do |time|
          SpentTime.new(time: time) do |s|
            s.activity = a
            s.save!
          end
        end
      end
    end

    it "returns the most recent" do
      SpentTime.last_updated.time.should == 10
    end
  end
end
