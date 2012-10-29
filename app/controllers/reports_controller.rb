class ReportsController < ApplicationController
  respond_to :html

  def index
    @report = Report.new(params[:report])
  end
end
