require 'rspec/core'
require 'extensions/rspec'

class TestParser::RSpec < Struct.new(:example)
  def self.find_tests!(path, glob = 'spec/**/*_spec.rb')
    ::RSpec.with_world ::RSpec::Core::World.new do |world|
      Dir[path + glob].each {|f| require f }
      
      examples = world.example_groups.collect_concat(&:descendant_filtered_examples)
      examples.map do |example|
        new(example).build_test
      end
    end
  end

  def build_test
    Test.new(test_identification, test_snippet)
  end
  def test_snippet
    @test_snippet ||= begin
      source_code = SourceCode.for(example.file_path)
      source_code.extract_code_from_line(example_line_number)
    end
  end
  def example_line_number
    example.metadata[:line_number]
  end
  def example_description
    example.description.empty? ? test_snippet.get_block.to_code : example.description
  end
  def test_identification
    (example_group_names.reverse + [example_description]).join('/')
  end
  def example_group_names
    example.example_group.ancestors.map(&:display_name)
  end
end