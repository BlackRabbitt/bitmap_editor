require 'minitest/autorun'

require './lib/commands/fill'
require './lib/commands/create'
require './lib/commands/horizontal_draw'
require './lib/commands/vertical_draw'
require './lib/commands/set_pixel'

class FillTest < MiniTest::Test
  def test_if_exists
    cmd = Fill.new(["1", "1", "R"])
    assert_kind_of Fill, cmd
  end

  def test_if_it_handles_invalid_arguments
    cmd = Fill.new("This should not valid")
    assert nil != cmd.err, "err object should exist for non-array parameter."

    cmd = Fill.new(["A", "1", "B"])
    assert nil != cmd.err, "err object should exist for 1 non-permitted arguments"

    cmd = Fill.new(["0", "2", "R"])
    assert nil != cmd.err, "err object should exist if the arguments is smaller than 1"

    cmd = Fill.new(["2", "255", "R"])
    assert nil != cmd.err, "err object should exist if the arguments is greater than 250"

    cmd = Fill.new(["1", "3", "R", "X"])
    assert nil != cmd.err, "err object should exist if it has extra arguments."

    cmd = Fill.new(["2", "5", "R"])
    assert_nil cmd.err, "This is a valid arguments."
  end

  def test_continuous_method
    bitmap_array = BitmapArray.new
    cmd = Create.new(["3", "3"])
    cmd.execute_on(bitmap_array)

    cmd = HorizontalDraw.new(["1", "2", "1", "Z"])
    cmd.execute_on(bitmap_array)

    cmd = VerticalDraw.new(["1", "1", "3", "Z"])
    cmd.execute_on(bitmap_array)

    cmd = SetPixel.new(["3", "2", "Z"])
    cmd.execute_on(bitmap_array)

    cmd = SetPixel.new(["2", "2", "T"])
    cmd.execute_on(bitmap_array)

    cmd = Fill.new(["1", "1", "R"])
    cmd.execute_on(bitmap_array)

    assert_equal("R", bitmap_array.color_of(1, 1))
    assert_equal("R", bitmap_array.color_of(3, 2))
    assert_equal("R", bitmap_array.color_of(1, 3))
  end
end
