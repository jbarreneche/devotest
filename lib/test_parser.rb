require 'pathname'
require 'source_code'
require 'models/test'

module TestParser
  autoload :MiniTest, 'test_parser/minitest'
  autoload :RSpec, 'test_parser/rspec'
end