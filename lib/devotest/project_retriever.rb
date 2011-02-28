require 'yaml'

module Devotest
  class ProjectRetriever

    attr_reader :project

    def self.initialize_repo(project)
      repository   = project.git_repository
      projects_dir = project.local_repo_path.to_s

      Grit::Git.new(projects_dir).clone({}, repository, projects_dir)
    end

    def initialize(project)
      @project = project
    end

    def latest_test_suite_revision
      repo.git.pull
      install_bundler_dependencies if project_uses_bundler?
      repo.commits.last.id
    end

    def retrieve_tests(libraries = %w[lib app example])
      libraries = libraries.map {|lib| "-I#{lib}" }.join(' ')

      yaml = run_safe_command %{test_parser #{libraries}}

      YAML.load yaml if $?.success?
    end

private

    def run_safe_command(command)
      Bundler.with_clean_env do
        %x[unset BUNDLE_GEMFILE && cd #{project.local_repo_path} && #{command}]
      end
    end
    
    def repo
      @repo ||= Grit::Repo.new(project.local_repo_path.to_s)
    end

    def project_uses_bundler?
      File.exists?(project.local_repo_path + "Gemfile")
    end

    def install_bundler_dependencies
      run_safe_command('bundle install vendor/bundle')
    end

  end  
end
