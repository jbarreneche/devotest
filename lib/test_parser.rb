require 'pathname'
require 'source_code'
require 'models/test'

module TestParser

  def find_tests_in_project!(path)
    MiniTest.find_tests!(path) + RSpec.find_tests!(path)
  end

  def require_all(path, glob)
    Dir[sanitize_path(path) + glob].each {|f| require f }
  end

  def sanitize_path(path)
    return path if path.is_a? Pathname
    Pathname.new(path)
  end

  extend self
end

require 'test_parser/minitest'
require 'test_parser/rspec'
