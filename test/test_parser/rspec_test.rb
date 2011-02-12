require 'minitest/autorun'

require 'bundler'
Bundler.setup
Bundler.require :default

require_relative '../../spec/support/projects_paths'
require 'test_parser'

# This test is only to check there isn't any side effect for testing with Rspec
# while parsing RSpec specs.
class RSpecTest < MiniTest::Unit::TestCase
  include ProjectsPaths
  
  def test_rspec_parsing
    tests = TestParser::RSpec.find_tests!(path_for_test_project)
    assert_equal 1, tests.size
    test = tests.first
    assert_equal 'Life/actually lives', test.identification
    assert code_matches?(test.to_code, <<-TEST)
      it 'actually lives' do
        Life.new.should be_alive
      end
    TEST
  end
  def code_matches?(actual, expected)
    expected_sexp = RubyParser.new.parse(expected)
    actual_sexp = RubyParser.new.parse(actual)
    expected_sexp == actual_sexp
  end
end