require 'spec_helper'

describe Activity do
  it { should_not be_done }
  its(:description) { should == "" }
  it { should have_many(:spent_times).dependent(:destroy) }

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
end
