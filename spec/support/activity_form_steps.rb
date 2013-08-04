module ActivityFormSteps
  RSpec.configure do |config|
    config.include self, type: :feature
  end

  def activity_form
    find("form#new-activity")
  end
end
