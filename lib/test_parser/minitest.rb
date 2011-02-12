require 'minitest/unit'

class TestParser::MiniTest
  def self.find_tests!(path, glob = 'test/**/*_test.rb')
    Dir[path + glob].each {|f| require f }
    MiniTest::Unit::TestCase.test_suites.map do |klass|
      klass_sym = klass.to_s.to_sym

      klass.test_methods.map do |test| 
        file_name = klass.instance_method(test).source_location.first
        code_snippet = SourceCode.for(file_name).extract_method(test)
        Test.new("#{klass.name}##{test}", code_snippet)
      end
    end.flatten
  end
end