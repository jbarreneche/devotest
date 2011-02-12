require 'ruby2ruby'
require 'forwardable'

class Test < Struct.new(:identification, :snippet)
  extend Forwardable
  def_delegators :snippet, :to_code, :sexp

end