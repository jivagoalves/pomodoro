class SpentTimesController < ApplicationController
  respond_to :html, :json

  before_filter :load_activity

  def index
    respond_with(spent_times)
  end

  def create
    spent_time = SpentTime.new(params[:spent_time])
    spent_time.save
    respond_with @activity, spent_time
  end

  private

  def load_activity
    @activity = Activity.find(params[:activity_id]) if params[:activity_id]
  end

  def spent_times
    @activity ? @activity.spent_times : SpentTime.updated_today
  end
end
