require 'spec_helper'
require 'date/date_range'

describe Activity do
  context "after initialization" do
    it { should_not be_done }

    its(:description) { should be_blank }
  end

  describe "default scope" do
    before do
      2.times do |i|
        Activity.new(description: i) do |a|
          a.updated_at = (i + 1).second.ago
          a.save!
        end
      end
    end

    it "orders by update date desc" do
      Activity.all.map(&:description).should == ['0', '1']
    end
  end

  describe ".ordered_by_most_active" do
    let(:now) { Time.now }
    let(:one_hour_ago) { now - 1.hour }
    let(:two_hours_ago) { now - 2.hours }

    before do
      Activity.new(description: 'Not active') do |a|
        a.updated_at = two_hours_ago
        a.save!
      end

      Activity.create!(description: 'Less active').tap do |a|
        SpentTime.new(time: 5) do |s|
          s.activity = a
          s.updated_at = one_hour_ago
          s.save!
        end
      end

      Activity.create!(description: 'More active').tap do |a|
        SpentTime.new(time: 5) do |s|
          s.activity = a
          s.updated_at = now
          s.save!
        end
      end
    end

    it "orders by most active" do
      activities = Activity.ordered_by_most_active
      activities.map(&:description).should == [
        'More active',
        'Less active',
        'Not active'
      ]
    end
  end

  describe ".executed_at(period)" do
    before do
      2.times do |n|
        Activity.create! do |a|
          SpentTime.new(time: 10 + n) do |s|
            s.activity = a
            s.created_at = Time.now + n.days
            s.updated_at = Time.now + n.days
            s.save!
          end
        end
      end
    end

    it "returns activities executed in the period" do
      activities = Activity.executed_at DateRange.new(
        Date.yesterday,
        Date.today
      )
      activities.should have(1).item
      activities.first.spent_times.map(
        &:time
      ).should include(10)
    end
  end

  describe "#activeness" do
    let(:now) { Time.zone.now }
    let(:one_hour_from_now) { now + 1.hour }

    context "when there are spent times" do
      before do
        Activity.new do |a|
          a.updated_at = now
          a.save!
          SpentTime.new do |s|
            s.activity = a
            s.updated_at = one_hour_from_now
            s.save!
          end
        end
      end

      it "returns the most recent spent time's updated_at" do
        activity = Activity.first
        spent_time = SpentTime.first
        activity.activeness.should eq(spent_time.updated_at)
        activity.activeness.should_not eq(activity.updated_at)
      end
    end

    context "when there is no spent time" do
      before do
        Activity.create!
      end

      it "returns the activity's updated_at" do
        activity = Activity.first
        activity.activeness.should == activity.updated_at
      end
    end
  end

  describe "#time_spent_at(period)" do
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

    it "returns total time spent in the period" do
      time = activity.time_spent_at DateRange.new(
        Date.yesterday - 1.day,
        Date.yesterday
      )
      time.should == 0

      time = activity.time_spent_at DateRange.new(
        Date.today,
        Date.tomorrow
      )
      time.should == 20
    end
  end

  describe "#time_spent_per_day_at(period)" do
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

    it "returns an array of time per day in the period" do
      times = activity.time_spent_per_day_at DateRange.new(
        Date.today,
        Date.tomorrow
      )
      times.should == [1,2]
    end
  end

  describe "#last_execution_at" do
    context "when there are spent times of the activity" do
      before do
        Activity.create! do |activity|
          SpentTime.new do |s|
            s.activity = activity
            s.save!
          end
        end
      end

      it "returns the updated_at of most recent spent time" do
        act = Activity.first
        spent_time = SpentTime.first
        act.last_execution_at.should == spent_time.updated_at
      end
    end

    context "when there is no spent times" do
      it "returns nil" do
        Activity.create!.last_execution_at.should be_nil
      end
    end
  end
end
