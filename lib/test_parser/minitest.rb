require 'minitest/unit'
require 'ruby_parser'
require 'ruby2ruby'
require 'models/test'

class TestParser::MiniTest
  def self.find_tests!(path, glob = 'test/**/*_test.rb')
    Dir[path + glob].each {|f| require f }
    MiniTest::Unit::TestCase.test_suites.map do |klass|
      klass_sym = klass.to_s.to_sym
      sources = Hash.new {|h, k| h[k] = [] }
      
      klass.test_methods.each do |test| 
        location = klass.instance_method(test).source_location.first
        sources[location] << test
      end
      sources.map do |source, methods|
        parser = RubyParser.new
        snippet = Ruby2Ruby.new
        source_sexp = parser.parse File.read(source)
        class_definition = source_sexp if source_sexp.sexp_type == :class && source_sexp.sexp_body.sexp_type == klass_sym
        class_definition ||= source_sexp.enum_for(:each_of_type, :class).find {|class_def| class_def.sexp_body.sexp_type == klass_sym }
        class_definition.enum_for(:each_of_type, :defn).map do |code_sexp|
          test_name = code_sexp.sexp_body.sexp_type
          Test.new("#{klass.name}##{test_name}", snippet.process(code_sexp))
        end
      end
    end.flatten
  end
end