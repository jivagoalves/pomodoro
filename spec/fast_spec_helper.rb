unless defined?(Rails)
  module Rails
    def self.root
      File.dirname(__FILE__) + '/../'
    end
  end

  $:.unshift Rails.root + "app/models"
  $:.unshift Rails.root + "app/presenters"
  $:.unshift Rails.root + "lib"
else
  require 'spec_helper'
end

module Pomodoro
end
