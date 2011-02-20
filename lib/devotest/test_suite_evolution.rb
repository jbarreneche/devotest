class TestSuiteEvolution

  attr_reader :former_test_suite, :new_test_suite, :strategies

  def initialize(former, current, strategies = [IdentificationMatcher])
    @former_test_suite, @new_test_suite = former, current
    @strategies = strategies
  end

  def evolve!
    remaining_tests = former_test_suite.to_a
    new_test_suite.each do |new_test|

      best_fit = remaining_tests.each_with_index.map do |idx, test|
        strategies.map do |strategy|
          strategy.evolve(idx, :from => new_test, :to => test)
        end.sort.first
      end.sort.first

      if best_fit.acceptable_grade?
        old_test  = remaining_tests.delete_at(best_fit.index)
        new_test.previous_test_version = old_test
      end

    end
  end
end