require 'spec_helper'

require 'test_parser'
describe TestParser::MiniTest do
  before(:all) do
    MiniTest::Unit::TestCase.reset
  end
  after(:all) do
    MiniTest::Unit::TestCase.reset
  end
  it 'parses minitest testcases' do
    tests = TestParser::MiniTest.find_tests! path_for_test_project
    tests.size.should == 1
    test = tests.first
    test.identification.should == 'TestSomething#test_foo'
    test.to_code.should match_code(<<-TEST)
      def test_foo
        life = Life.new
        assert life.alive?
      end
    TEST
  end
end