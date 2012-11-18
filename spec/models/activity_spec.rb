require 'spec_helper'

describe Activity do
  context "after initialization" do
    it { should_not be_done }

    its(:description) { should == "" }
  end

  describe "default scope" do
    before do
      2.times do |i|
        Activity.new(description: i) do |a|
          a.created_at = (i + 1).second.ago
          a.save!
        end
      end
    end

    it "orders by creation date desc" do
      Activity.all.map(&:description).should == ['0', '1']
    end
  end

  describe ".executed_between" do
    before do
      2.times do |n|
        Activity.create! do |a|
          SpentTime.new(time: 10 + n) do |s|
            s.activity = a
            s.created_at = Date.today + n.days
            s.updated_at = Date.today + n.days
            s.save!
          end
        end
      end
    end

    it "returns activities executed between a period" do
      activities = Activity.executed_between(
        Date.yesterday,
        Date.today
      )
      activities.should have(1).item
      activities.first.spent_times.map(&:time).should include(10)
    end
  end

  describe "#time_spent_between" do
    let(:activity) { Activity.create! }

    before do
      3.times do |n|
        SpentTime.new(time: 10) do |s|
          s.created_at = s.updated_at = Time.now + n.days
          s.activity = activity
          s.save!
        end
      end
    end

    it "returns the time spent between a period of time" do
      time = activity.time_spent_between(
        Date.yesterday - 1.day,
        Date.yesterday
      )
      time.should == 0

      time = activity.time_spent_between(
        Date.today,
        Date.tomorrow
      )
      time.should == 20
    end
  end

  describe "#time_spent_per_day_between" do
    let(:activity) { Activity.create! }

    before do
      2.times do |n|
        SpentTime.new(time: 1 + n) do |s|
          s.created_at = s.updated_at = Time.now + n.days
          s.activity = activity
          s.save!
        end
      end
    end

    it "returns an array of time per day in a period" do
      times = activity.time_spent_per_day_between(
        Date.today,
        Date.tomorrow
      )
      times.should == [1,2]
    end
  end
end
