class Project < ActiveRecord::Base
  validates :name, :git_repository, :presence => true
  has_many :test_suites

  def initialize_repo
    if persisted? && project_not_retrieved?
      ProjectRetriever.initialize_repo(git_repository, local_repo_path.to_s)
    end
  end

  def rebuild_current_test_suite
    initialize_repo if project_not_retrieved?
    
    revision = ProjectRetriever.latest_test_suite_revision(local_repo_path.to_s)
    return current_test_suite if revision == current_test_suite.try(:revision)

    self.test_suites.build :tests => TestParser.all_tests(local_repo_path)
  end

  def current_test_suite
    test_suites.last
  end

  def local_repo_path
    return '' unless persisted?
    Rails.root + "tmp" + id.to_s
  end

  def project_not_retrieved?
    persisted? && local_repo_path.exist?
  end
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

