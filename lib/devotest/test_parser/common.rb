module TestParser
  module Common

    def build_test
      TestDefinition.new(:identification => test_identification, :snippet => test_snippet)
    end

    def test_source_code
      SourceCode.for(test_file_name)
    end

  end
end