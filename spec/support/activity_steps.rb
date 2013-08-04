module ActivitySteps
  RSpec.configure do |config|
    config.include self, type: :feature
  end

  def list_of_activities
    find("#activities")
  end

  def have_activities
    have_css(".activity")
  end
end
