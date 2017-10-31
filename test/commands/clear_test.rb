require 'minitest/autorun'

require './lib/commands/create'
require './lib/commands/clear'
require './lib/commands/horizontal_draw'

require './lib/bitmap_array'

class ClearTest < MiniTest::Test
  def test_if_exists
    cmd = Clear.new
    assert_kind_of Clear, cmd
  end

  def test_if_it_handles_invalid_arguments
    cmd = Clear.new("This should not valid")
    assert nil != cmd.err, "err object should exist for non-array parameter."

    cmd = Clear.new(["A", "B"])
    assert nil != cmd.err, "expected to have 0 arguments"

    cmd = Clear.new()
    assert_nil cmd.err, "This is a valid arguments."
  end

  def test_if_it_works
    bitmap_array = BitmapArray.new
    cmd = Clear.new
    err = cmd.execute_on(bitmap_array)
    assert nil != err, "err object should exist if clear is called in empty bitmap-array. Create should be called first."

    cmd = Create.new(["5", "6"])
    cmd.execute_on(bitmap_array)

    cmd = HorizontalDraw.new(["1", "4", "3", "X"])
    cmd.execute_on(bitmap_array)

    assert_equal bitmap_array[3][2], "X", "Assuring that pixel(2,3) is coloured with 'X'"

    cmd = Clear.new
    err = cmd.execute_on(bitmap_array)

    assert_equal bitmap_array[3][2], "O", "Every bit should be cleared."
    assert_nil err, "err object must be nil"
  end
end
