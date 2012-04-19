require 'spec_helper'

describe "activities/new" do
  before :each do
    act = mock_model('Activity')
    act.stub(:description).
      and_return('description 1')
    assign(:activities, [act])
    assign(:activity, mock_model('Activity').as_new_record)
    render
  end

  it 'should have a div with id counter' do
    rendered.should have_selector('#counter')
  end

  it 'should have the counter with content 25:00' do
    rendered.should have_selector('#counter', :text => '25:00')
  end

  it 'should have a form for @activity' do
    rendered.should have_selector('form',
                                  :method => 'post',
                                  :action => activities_path)
  end

  it 'should have a field text for description' do
    rendered.should have_selector(
      'form input[type="text"][name="activity[description]"]'
    )
  end

  it 'should render all exiting activities' do
    rendered.should have_selector('.activity', :text => 'description 1')
  end
end
