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
    tests = TestParser::MiniTest.find_tests! test_project_path
    tests.size.should == 1
    test = tests.first
    test.identification.should == 'TestSomething#test_foo'
    test.code.should match_code(<<-TEST)
      def test_foo
        life = Life.new
        assert life.alive?
      end
    TEST
  end
end