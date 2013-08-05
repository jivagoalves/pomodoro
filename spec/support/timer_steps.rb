module TimerSteps
  RSpec.configure do |config|
    config.include self, type: :feature
  end

  def timer
    find("#timer")
  end
end
