class Project < ActiveRecord::Base
  has_many :test_suites
end

# == Schema Information
#
# Table name: projects
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  git_repository :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

