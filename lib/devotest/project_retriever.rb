require 'yaml'

class ProjectRetriever
  # extend self
  attr_reader :project
  
  def initialize(project)
    @project = project
  end

  def self.initialize_repo(repository, local_path)
    Grit::Git.new('.').clone({}, repository, local_path)
  end

  def latest_test_suite_revision
    repo = Grit::Repo.new(project.local_repo_path.to_s)
    repo.git.pull
    install_bundler_dependencies if project_uses_bundler?
    repo.commits.last.id
  end
  
  def retrieve_tests(libraries = %w[lib app example])
    libraries = libraries.map {|lib| "-I#{lib}" }.join(' ')

    yaml = run_safe_command %{ruby #{libraries} -S test_parser .}

    YAML.load yaml if $?.success?
  end
  
  def project_uses_bundler?
    File.exists?(project.local_repo_path + "Gemfile")
  end
  
  def install_bundler_dependencies
    run_safe_command('bundle install vendor/bundle')
  end
  
  def run_safe_command(command)
    Bundler.with_clean_env do
      %x[unset BUNDLE_GEMFILE && cd #{project.local_repo_path} && #{command}]
    end
  end
end