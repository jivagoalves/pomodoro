class ReportsController < ApplicationController
  respond_to :html

  def index
    @report = ActivityReport.new(params[:activity_report])
  end
end
