require 'forwardable'

class TestDefinition < ActiveRecord::Base
  belongs_to :previous_test_version, :class_name => "TestDefinition"
  has_and_belongs_to_many :test_suites

  delegate :sexp, :to_code, :to => :snippet
  serialize :snippet, TestParser::Snippet

  def self.build_from_info(test)
    new(
      :snippet        => test.snippet,
      :identification => test.identification
    )
  end

end

# == Schema Information
#
# Table name: test_definitions
#
#  id             :integer         not null, primary key
#  identification :string(255)
#  snippet        :text
#  created_at     :datetime
#  updated_at     :datetime
#

