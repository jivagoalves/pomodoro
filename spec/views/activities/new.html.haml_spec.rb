require 'spec_helper'

describe "activities/new" do
  before :each do
    assign(:activity, mock_model('Activity').as_new_record)
    render
  end

  it 'should have a form for @activity' do
    rendered.should have_selector('form',
                                  :method => 'post',
                                  :action => activities_path)
  end

  it 'should have a field text for description' do
    rendered.should have_selector('form input[type="text"][name="activity[description]"]')
  end

  it 'should have a submit button' do
    rendered.should have_selector('form input[type="submit"]')
  end
end
