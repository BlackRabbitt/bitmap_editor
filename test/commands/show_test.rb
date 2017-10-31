require 'minitest/autorun'

require './lib/commands/show'
require './lib/commands/create'
require './lib/commands/horizontal_draw'

require './lib/bitmap_array'

class ShowTest < MiniTest::Test
  def test_if_exists
    cmd = Show.new
    assert_kind_of Show, cmd
  end

  def test_if_it_handles_invalid_arguments
    cmd = Show.new("This should not valid")
    assert nil != cmd.err, "err object should exist for non-array parameter."

    cmd = Show.new(["A", "B"])
    assert nil != cmd.err, "expected to have 0 arguments"

    cmd = Show.new()
    assert_nil cmd.err, "This is a valid arguments."
  end

  def test_if_it_works
    bitmap_array = BitmapArray.new
    cmd = Show.new
    err = cmd.execute_on(bitmap_array)
    assert nil != err, "err object should exist if show is called in empty bitmap-array. Create should be called first."

    cmd = Create.new(["5", "6"])
    cmd.execute_on(bitmap_array)

    cmd = HorizontalDraw.new(["1", "4", "3", "X"])
    cmd.execute_on(bitmap_array)

    cmd = Show.new
    err = cmd.execute_on(bitmap_array)

    assert_nil err, "err object must be nil"
  end
end
