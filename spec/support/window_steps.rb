module WindowSteps
  RSpec.configure do |config|
    config.include self, type: :feature
  end

  def stub_confirm_to_return(value)
    page.execute_script("window.confirm = function(_){ return #{value}; }")
  end
end
