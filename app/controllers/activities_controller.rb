class ActivitiesController < ApplicationController
  def new
    @activity = Activity.new
  end

  def create
    activity = Activity.new(params[:activity])
    if activity.save
      redirect_to new_activity_path
    else
      render 'new'
    end
  end
end
