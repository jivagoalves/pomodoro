require 'spec_helper'

describe Activity do
  let(:activity) { Activity.new }

  it 'should have a property: description' do
    activity.description = "my description"
    activity.description.should == "my description"
  end

  it 'should have a property: done' do
    activity.done = true
    activity.done.should == true
  end

  describe '#new' do
    it 'should initialize description with ""' do
      activity.description.should == ""
    end

    it 'should initialize done with false' do
      activity.done.should == false
    end
  end

  context 'on loading an activity from the database' do
    before :each do
      activity.description = "my description"
      activity.done = true
      activity.save
    end

    it 'should not overwrite with default values' do
      activity_found = Activity.find_by_id(activity.id)
      activity_found.description.should == "my description"
      activity_found.done.should == true
    end
  end
end
