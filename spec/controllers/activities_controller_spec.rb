require 'spec_helper'

describe ActivitiesController do
  describe '#new' do
    before :each do
      mock_model('Activity')
      Activity.should_receive(:new).and_return("a new activity")
      Activity.should_receive(:all).and_return(['activities'])
      SpentTime.should_receive(
        :updated_today
      ).and_return(['spent times'])

      get :new
    end

    it 'renders the new template' do
      response.should render_template('new')
    end

    it 'assigns @activity with a new activity' do
      assigns(:activity).should == "a new activity"
    end

    it 'assigns @activities with all existing activities' do
      assigns(:activities).should == ['activities']
    end

    it 'assigns @spent_times with SpentTime.updated_today' do
      assigns(:spent_times).should == ['spent times']
    end
  end

  describe '#create' do
    let(:activity) { mock_model('Activity').as_null_object }

    before :each do
      Activity.stub(:new).and_return(activity)
    end

    it 'creates a new activity from user input' do
      Activity.should_receive(:new).with(
        'description' => 'my activity'
      )

      post :create, :activity => {'description' => 'my activity'}
    end

    it 'asks to save the activity' do
      activity.should_receive(:save)
      post :create, :activity => {'description' => 'my activity'}
    end

    context 'when the activity saves successfully' do
      before :each do
        activity.stub(:save).and_return(true)
      end

      it 'redirects to new template' do
        post :create, :activity => {'description' => 'my activity'}
        controller.should respond_with(:redirect)
      end
    end

    context 'when the activity creation fails' do
      before :each do
        activity.stub(:errors).and_return(['error'])
      end

      it 'renders the new template' do
        post :create, :activity => {}
        response.should render_template('new')
      end
    end
  end
end
