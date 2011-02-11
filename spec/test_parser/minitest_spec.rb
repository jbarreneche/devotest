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
    load('fixtures/minitest_example.rb')
    tests = TestParser::MiniTest.find_tests!
    tests.size.should == 1
    test = tests.first
    test.identification.should == 'TestSomething#test_foo'
    test.code.should match_code(<<-TEST)
      def test_foo
        foo = Foo.new
        assert foo
        bar = nil
        assert_nil bar
      end
    TEST
  end
end