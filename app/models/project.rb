class Project < ActiveRecord::Base
  validates :name, :git_repository, :presence => true
  has_many :test_suites
  has_many :tests, :class_name => "TestDefinition"

  def initialize_repo
    unless new_record? || project_retrieved?
      Devotest::ProjectRetriever.initialize_repo(self)
    end
  end

  def rebuild_current_test_suite
    initialize_repo unless project_retrieved?
    
    return current_test_suite if latest_version_parsed?

    tests = project_retriever.retrieve_tests
    if tests
      tests.map! {|test| TestDefinition.build_from_info(test) }
      test_suites.create :tests => tests, :revision => latest_revision
    end

  end

  def current_test_suite
    test_suites.first
  end

  def local_repo_path
    return '' unless persisted?
    Rails.root + "tmp" + to_param
  end

  def project_retrieved?
    persisted? && local_repo_path.exist?
  end

  def latest_version_parsed?
    current_test_suite? && 
    current_test_suite.revision == project_retriever.latest_test_suite_revision
  end

  def current_test_suite?
    !current_test_suite.nil?
  end

private

  def latest_revision
    project_retriever.latest_test_suite_revision
  end

  def project_retriever
    @project_retriever ||= Devotest::ProjectRetriever.new(self)
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
