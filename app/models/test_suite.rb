class TestSuite < ActiveRecord::Base
  has_and_belongs_to_many :tests, :class_name => "TestDefinition"
  include Enumerable
  
  def each
    return enum_for(:each) unless block_given?
    tests.each {|test| yield(test) }
  end
end

# == Schema Information
#
# Table name: test_suites
#
#  id         :integer         not null, primary key
#  project_id :integer
#  revision   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

