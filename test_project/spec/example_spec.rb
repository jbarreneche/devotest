require_relative 'spec_helper'

describe Life do
  it 'actually lives' do
    Life.new.should be_alive
  end
end