RSpec::Matchers.define :match_code do |expected|
  match do |actual|
    expected_sexp = RubyParser.new.parse(expected)
    actual_sexp = RubyParser.new.parse(actual)
    expected_sexp == actual_sexp
  end
end