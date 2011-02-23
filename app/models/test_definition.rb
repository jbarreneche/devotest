require 'forwardable'

class TestDefinition < ActiveRecord::Base
  belongs_to :previous_test_version, :class_name => "TestDefinition"
  has_many :comments, :as => :commentable
  has_and_belongs_to_many :test_suites

  delegate :sexp, :to_code, :to => :snippet
  serialize :snippet, TestParser::Snippet

  def self.build_from_info(test)
    new(
      :snippet           => test.snippet,
      :identification    => test.identification,
      :testing_framework => test.type
    )
  end

end


# == Schema Information
#
# Table name: test_definitions
#
#  id                       :integer         not null, primary key
#  test_suite_id            :integer
#  previous_test_version_id :integer
#  identification           :string(255)
#  snippet                  :text
#  testing_framework        :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#

