require 'spec_helper'

describe ActivitiesController do
  describe '#new' do
    before :each do
      mock_model('Activity')
      Activity.should_receive(:new).and_return("a new activity")
      get :new
    end

    it 'should render the new template' do
      response.should render_template('new')
    end

    it 'should assign @activity with a new activity' do
      assigns(:activity).should == "a new activity"
    end
  end
end
