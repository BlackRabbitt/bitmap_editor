require 'minitest/autorun'

require './lib/commands/create'
require './lib/bitmap_array'

class CreateTest < MiniTest::Test
  def test_if_exists
    cmd = Create.new(["5", "6"])
    assert_kind_of Create, cmd
  end

  def test_if_it_handles_invalid_arguments
    cmd = Create.new("This should not valid")
    assert nil != cmd.err, "err object should exist for non-array parameter create create command."

    cmd = Create.new(["A", "B"])
    assert nil != cmd.err, "err object should exist for non-integer arguments for create command"

    cmd = Create.new([0, 0])
    assert nil != cmd.err, "err object should exist if the arguments is smaller than 1"

    cmd = Create.new([1, 255])
    assert nil != cmd.err, "err object should exist if the arguments is smaller than 250"

    cmd = Create.new([1, 3, 4])
    assert nil != cmd.err, "err object should exist if it has extra arguments."

    cmd = Create.new([250, 1])
    assert_nil cmd.err, "This is a valid arguments."
  end

  def test_if_it_works
    bitmap_array = BitmapArray.new
    cmd = Create.new([4, 6])
    cmd.execute_on(bitmap_array)

    assert 4, bitmap_array.length
    assert 6, bitmap_array.height

    assert "0", bitmap_array[3][2]
  end
end
