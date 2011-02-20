class ProjectRetriever
  # extend self
  
  def self.initialize_repo(repository, local_path)
    Grit::Git.new('.').clone({}, repository, local_path)
  end

  def latest_test_suite_revision(local_path)
    repo = Grit::Repo.new(local_path)
    repo.git.pull
    repo.commits.last.id
  end
end