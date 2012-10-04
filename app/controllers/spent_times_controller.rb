class SpentTimesController < ApplicationController
  respond_to :html, :json

  def index
    respond_with(
      SpentTime.find_all_by_activity_id(params[:activity_id])
    )
  end

  def create
    activity = Activity.find(params[:activity_id])
    spent_time = SpentTime.new(params[:spent_time])
    if spent_time.save
      respond_with activity, spent_time
    else
      respond_with activity, spent_time, status: :unprocessable_entity
    end
  end
end
