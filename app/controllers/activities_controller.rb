class ActivitiesController < ApplicationController
  respond_to :html, :json

  def index
    respond_with(@activities = Activity.all)
  end

  def new
    @activity = Activity.new
    @activities = Activity.all
    @spent_times = SpentTime.updated_today
  end

  def create
    activity = Activity.new(params[:activity])
    if activity.save
      respond_with activity
    else
      respond_with activity, status: :unprocessable_entity
    end
  end

  def destroy
    Activity.find(params[:id]).destroy
    redirect_to root_path
  end
end
