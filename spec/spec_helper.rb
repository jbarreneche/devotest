
require 'bundler'
Bundler.setup
Bundler.require :default, :test

# Dir[File.expand_path('../spec/support/**/*.rb', __FILE__)].each {|f| require f }
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f} 
