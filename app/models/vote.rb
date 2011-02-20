class Vote < ActiveRecord::Base
  belongs_to :test_definition
end

# == Schema Information
#
# Table name: votes
#
#  id                 :integer         not null, primary key
#  test_definition_id :integer
#  value              :integer
#  created_at         :datetime
#  updated_at         :datetime
#

