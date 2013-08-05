module SpentTimeSteps
  RSpec.configure do |config|
    config.include self, type: :feature
  end

  def total_spent_time
    find("#total-spent-time")
  end

  def have_time
    have_content(/[1-9]\d{0,1}s/)
  end
end
