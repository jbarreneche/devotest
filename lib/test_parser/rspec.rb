require 'rspec/core'
require 'extensions/rspec'

class TestParser::RSpec
  def self.find_tests!(path, glob = 'spec/**/*_spec.rb')
    with_world ::RSpec::Core::World.new do |world|
      Dir[path + glob].each {|f| require f }
      
      world.example_groups.map(&:descendant_filtered_examples).flatten.map do |example|
        line_number =  example.metadata[:line_number]
        snippet = SourceCode.for(example.file_path).extract_code_from_line(line_number)
        Test.new("#{example.example_group.display_name}/#{example.description}", snippet)
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