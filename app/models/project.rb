class Project < ActiveRecord::Base
  validates :name, :git_repository, :presence => true
  has_many :test_suites

  def initialize_repo
    unless project_retrieved?
      ProjectRetriever.initialize_repo(git_repository, local_repo_path.to_s)
    end
  end

  def rebuild_current_test_suite
    initialize_repo unless project_retrieved?
    
    retriever = ProjectRetriever.new(self)
    revision = retriever.latest_test_suite_revision
    return current_test_suite if revision == current_test_suite.try(:revision)

    if tests = retriever.retrieve_tests
      tests.map! {|test| TestDefinition.build_from_info(test) }
      self.test_suites.create :tests => tests, :revision => revision
    end
  end

  def current_test_suite
    test_suites.first
  end

  def local_repo_path
    return '' unless persisted?
    Rails.root + "tmp" + id.to_s
  end

  def project_retrieved?
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

