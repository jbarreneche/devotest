require 'spec_helper'

describe TestParser::MiniTest do
  it 'parses rspec describe' do
    tests = TestParser::RSpec.find_tests!(path_for_test_project)
    tests.size.should == 1
    test = tests.first
    test.identification.should == 'Life/actually lives'
    test.to_code.should match_code(<<-TEST)
      it 'actually lives' do
        Life.new.should be_alive
      end
    TEST
  end
end