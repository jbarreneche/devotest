class TestSomething < MiniTest::Unit::TestCase
  def test_foo
    foo = Foo.new
    assert foo
    bar = nil
    assert_nil bar
  end
end