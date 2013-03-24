#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

if Rails.env.test? || Rails.env.development?
  require 'guard/jasmine/task'
  Guard::JasmineTask.new
end

Pomodoro::Application.load_tasks
