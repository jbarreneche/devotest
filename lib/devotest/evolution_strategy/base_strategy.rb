module EvolutionStrategy
  module BaseStrategy
    def evolve(index, evolve)
      Evolution.new(index, grade(evolve[:from], evolve[:to]))
    end
  end
end
