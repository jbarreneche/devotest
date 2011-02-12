require 'spec_helper'

describe TestParser::MiniTest do
  it 'parses rspec describe' do
    tests = TestParser::RSpec.find_tests!(test_project_path)
    tests.size.should == 1
    test = tests.first
    test.identification.should == 'Life/actually lives'
    test.code.should match_code(<<-TEST)
      it 'actually lives' do
        Life.new.should be_alive
      end
    TEST
  end
end