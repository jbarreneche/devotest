require 'forwardable'

class TestDefinition < Struct.new(:identification, :snippet)
  extend Forwardable
  def_delegators :snippet, :to_code, :sexp

end