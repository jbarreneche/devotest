require 'ruby2ruby'

class Snippet < Struct.new(:sexp)
  def to_code
    @to_code ||= Ruby2Ruby.new.process(self.sexp)
  end
end