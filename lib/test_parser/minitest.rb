require 'minitest/unit'

class TestParser::MiniTest < Struct.new(:klass, :test_method)

  def self.find_tests!(path, glob = 'test/**/*_test.rb')

    TestParser.require_all(path, glob)

    MiniTest::Unit::TestCase.test_suites.collect_concat do |klass|
      klass.test_methods.map do |test| 
        new(klass, test).build_test
      end
    end
  end

  def build_test
    Test.new(test_identification, test_snippet)
  end

  def test_snippet
    SourceCode.for(file_name).extract_method(test_method)
  end

  def file_name
    klass.instance_method(test_method).source_location.first
  end

  def test_identification
    "#{klass.name}##{test_method}"
  end

end