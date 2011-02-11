require 'pathname'
module ProjectsPaths
  def devotest_path
    Pathname.new File.join(File.dirname(__FILE__), '..', '..')
  end
  def test_project_path
    devotest_path + 'test_project'
  end
end