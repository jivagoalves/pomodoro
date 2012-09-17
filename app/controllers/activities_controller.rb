class ActivitiesController < ApplicationController
  def new
    @activity = Activity.new
    @activities = Activity.all
  end

  def create
    activity = Activity.new(params[:activity])
    if activity.save
      redirect_to new_activity_path
    else
      render 'new'
    end
  end

  def destroy
    Activity.find(params[:id]).destroy
    redirect_to root_path
  end
end
