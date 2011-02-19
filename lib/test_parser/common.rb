module TestParser
  module Common

    def build_test
      TestDefinition.new(test_identification, test_snippet)
    end

    def test_source_code
      SourceCode.for(test_file_name)
    end

  end
end