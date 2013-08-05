module AsyncSteps
  RSpec.configure do |config|
    config.include self, type: :feature
  end

  class AsyncStep < Struct.new(:page)
    def after(miliseconds)
      @miliseconds = miliseconds
      self
    end

    def click_link(text)
      self.page.execute_script(<<-JS)
        setTimeout(function(){
          $("a:contains('#{text}'):first").trigger('click')
        }, #{@miliseconds});
      JS
    end
  end

  def after(miliseconds)
    AsyncStep.new(page).after(miliseconds)
  end
end
