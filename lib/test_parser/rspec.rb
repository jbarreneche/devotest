require 'rspec/core'
require 'extensions/rspec'

class TestParser::RSpec
  def self.find_tests!(path, glob = 'spec/**/*_spec.rb')
    with_world ::RSpec::Core::World.new do |world|
      Dir[path + glob].each {|f| require f }
      
      world.example_groups.map(&:descendant_filtered_examples).flatten.map do |example|
        line_number = example.metadata[:line_number]
        snippet = SourceCode.for(example.file_path).extract_code_from_line(line_number)
        example_description = example.description.empty? ? snippet.get_block.to_code : example.description
        example_group_names = example.example_group.ancestors.reverse.map(&:display_name)
        path_to_example = (example_group_names + [example_description]).join('/')
        Test.new(path_to_example, snippet)
      end
    end
  end
  def self.with_world(world)
    old_world = ::RSpec.world
    ::RSpec.world = world
    result = yield(world)
    ::RSpec.world = old_world
    result
  end
end