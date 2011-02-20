module EvolutionStrategy
  module IdentificationMatcher
    extend BaseStrategy
    extend self

    def grade(from_test, to_test)
      from       = from_test.identification
      to         = to_test.identification
      max_length = [from.length, to.length].max.to_f
      distance   = Levenshtein.distance(from, to)
      return 1 - (distance / max_length)
    end

  end
end
