module CommonSteps
  RSpec.configure do |config|
    config.include self, type: :feature
  end

  def ensure_on(path)
    visit(path) unless current_path == path
  end
end
