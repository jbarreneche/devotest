RSpec::Matchers.define :match_code do |expected|
  expected_sexp = RubyParser.new.parse(expected)
  match do |actual|
    actual_sexp = actual.sexp if actual.respond_to? :sexp
    actual = actual.to_code   if actual.respond_to?(:to_code) && !actual_sexp
    actual_sexp ||= RubyParser.new.parse(actual)
    expected_sexp == actual_sexp
  end
end