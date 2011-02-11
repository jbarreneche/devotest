require 'spec_helper'

describe TestParser::MiniTest do
  it 'parses rspec describe' do
    TestParser::Rspec.find_tests!
  end
end