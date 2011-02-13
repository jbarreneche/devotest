require 'spec_helper'

describe TestParser::MiniTest do
  describe '.find_tests!' do
    context 'within test_project' do
      before(:all) do
        @tests = TestParser::RSpec.find_tests!(path_for_test_project)
        @test_identifications = @tests.map(&:identification)
      end
      it 'finds all the tests' do
        @tests.should have(2).tests
      end
      it 'finds not nested tests' do
        @test_identifications.should include('Life/actually lives')
        test = @tests[@test_identifications.index('Life/actually lives')]
        test.to_code.should match_code(<<-TEST)
          it 'actually lives' do
            Life.new.should be_alive
          end
        TEST
      end
      it 'finds nested tests' do
        @test_identifications.should include('Life/with death sentence/should(be_alive)')
        test = @tests[@test_identifications.index('Life/with death sentence/should(be_alive)')]
        test.to_code.should match_code("it { should be_alive }")
      end
    end
  end
end