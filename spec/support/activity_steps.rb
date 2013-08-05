module ActivitySteps
  RSpec.configure do |config|
    config.include self, type: :feature
  end

  def list_of_activities
    find("#activities")
  end

  def first_activity
    find(".activity")
  end

  def have_activities
    have_css(".activity")
  end

  def have_notification(notification)
    within ".notification" do
      have_content(notification)
    end
  end
end
