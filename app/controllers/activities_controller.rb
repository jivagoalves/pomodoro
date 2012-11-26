class ActivitiesController < ApplicationController
  respond_to :html, :json

  def index
    respond_with(@activities = Activity.all)
  end

  def new
    @activity = Activity.new
    @activities = Activity.ordered_by_most_active
    @spent_times = SpentTime.updated_today
  end

  def create
    activity = Activity.new(params[:activity])
    activity.save
    respond_with activity
  end

  def destroy
    activity = Activity.find(params[:id])
    activity.destroy
    respond_with(activity)
  end
end
