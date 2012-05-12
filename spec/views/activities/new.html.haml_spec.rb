require 'spec_helper'

describe "activities/new" do
  before :each do
    assign(:activity, mock_model('Activity').as_new_record)
    assign(:activities, [])
  end

  context 'in order to focus on activities' do
    before :each do
      assign(:activity, mock_model('Activity').as_new_record)
      render
    end

    it 'should have an area for timer' do
      rendered.should have_selector('#timer-area')
    end

    it 'should have a span with id timer' do
      rendered.should have_selector('#timer-area p span#timer')
    end

    it 'should have the timer with content 25:00' do
      rendered.should have_selector('#timer', :text => '25:00')
    end
  end

  context 'in order to add new activities' do
    before :each do
      assign(:activity, mock_model('Activity').as_new_record)
      render
    end

    it 'should have an area for activity' do
      rendered.should have_selector('#activity-area')
    end

    it 'should have a form for @activity' do
      rendered.should have_selector('#activity-area form',
                                    :method => 'post',
                                    :action => activities_path)
    end

    it 'should have a text field for description' do
      rendered.should have_selector('#new_activity p input' +
                                    '[type="text"]' +
                                    '[name="activity[description]"]')
    end

    it 'should have a submit button to add activities' do
      rendered.should have_selector('#new_activity input' +
                                    '[type="submit"]')
    end
  end

  context 'given existing activities' do
    let(:activities) do
      (0..3).each.inject([]) do |ary, n|
        ary << FactoryGirl.create(:activity,
                                  :description => "description #{n}")
      end
    end

    before :each do
      assign(:activities, activities)
      render
    end

    it 'should render all exiting activities' do
      activities.each do |activity|
        rendered.should have_selector('.activity',
                                      :text => activity.description)
      end
    end

    it 'should have a list of activities intentionally ordered' do
      activities.each do |activity|
        rendered.should have_selector('ol.activity-list li',
                                      :text => activity.description)
      end
    end
  end
end
