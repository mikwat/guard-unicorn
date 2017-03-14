require 'rspec'
require 'guard/compat/test/helper'
require 'guard/unicorn'

ENV['GUARD_ENV'] = 'test'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
