module RSpec
  def self.world=(new_world)
    @world = new_world
  end
end

RSpec::Core::Runner.disable_autorun!