require 'spec_helper'

describe ActivitiesController do
  describe '#new' do
    before :each do
      mock_model('Activity')
      Activity.should_receive(:new).and_return("a new activity")
      Activity.should_receive(:all).and_return(['activities'])
      get :new
    end

    it 'should render the new template' do
      response.should render_template('new')
    end

    it 'should assign @activity with a new activity' do
      assigns(:activity).should == "a new activity"
    end

    it 'should assign @activities with all existing activities' do
      assigns(:activities).should == ['activities']
    end
  end

  describe '#create' do
    let(:activity) { mock_model('Activity').as_null_object }

    before :each do
      Activity.stub(:new).and_return(activity)
    end

    it 'should create a new activity from user input' do
      Activity.should_receive(:new).with('description' => 'my activity')
      post :create, :activity => {'description' => 'my activity'}
    end

    it 'should ask to save the activity' do
      activity.should_receive(:save)
      post :create, :activity => {'description' => 'my activity'}
    end

    context 'when the activity saves successfully' do
      before :each do
        activity.stub(:save).and_return(true)
      end

      it 'should redirect to new template' do
        post :create, :activity => {'description' => 'my activity'}
        response.should redirect_to(new_activity_path)
      end
    end

    context 'when the activity creation fails' do
      before :each do
        activity.stub(:save).and_return(false)
      end

      it 'should render the new template' do
        post :create, :activity => {}
        response.should render_template('new')
      end
    end
  end
end
