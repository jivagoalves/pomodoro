require 'spec_helper'

describe SpentTime do
  its(:time) { should == 0 }
  it { should belong_to :activity }
  it { should validate_presence_of :activity }

  describe "#add_pomodoro" do
    it 'adds 1500s to the spent time' do
      st = SpentTime.new { |st| st.add_pomodoro }
      st.time.should == 1500
    end
  end
end
