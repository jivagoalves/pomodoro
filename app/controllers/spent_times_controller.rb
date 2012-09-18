class SpentTimesController < ApplicationController
  respond_to :json

  def create
    time = SpentTime.find_or_initialize_by_activity_id_and_created_at(params[:activity_id], Date.today) do |st|
      st.save
    end
    respond_with time, location: activity_spent_times_url
  end
end
