require 'ruby2ruby'

class Snippet < Struct.new(:sexp)

  def to_code
    @to_code ||= Ruby2Ruby.new.process(self.sexp.deep_clone)
  end

  def get_block
    Snippet.new(sexp[3])
  end

end