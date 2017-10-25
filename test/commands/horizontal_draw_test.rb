require 'minitest/autorun'

require './lib/commands/horizontal_draw'
require './lib/commands/create'

require './lib/bitmap_array'

class HorizontalDrawTest < MiniTest::Test
  def test_if_exists
    cmd = HorizontalDraw.new(["2", "5", "6", "A"])
    assert_kind_of HorizontalDraw, cmd
  end

  def test_if_it_handles_invalid_arguments
    cmd = HorizontalDraw.new("This should not valid")
    assert nil != cmd.err, "err object should exist for non-array parameter."

    cmd = HorizontalDraw.new(["A", "1", "B", "A"])
    assert nil != cmd.err, "err object should exist for 1 non-permitted arguments"

    cmd = HorizontalDraw.new(["2", "4", "B", "2"])
    assert nil != cmd.err, "err object should exist for 2 non-permitted arguments"

    cmd = HorizontalDraw.new(["2", "4", "3", "1"])
    assert nil != cmd.err, "err object should exist for 3 non-permitted arguments"

    cmd = HorizontalDraw.new(["0", "2", "3", "A"])
    assert nil != cmd.err, "err object should exist if the arguments is smaller than 1"

    cmd = HorizontalDraw.new(["2", "1", "255", "B"])
    assert nil != cmd.err, "err object should exist if the arguments is greater than 250"

    cmd = HorizontalDraw.new(["1", "3", "4", "X", "Y"])
    assert nil != cmd.err, "err object should exist if it has extra arguments."

    cmd = HorizontalDraw.new(["4", "1", "3", "X"])
    assert nil != cmd.err, "err object should exist if x2 < x1."

    cmd = HorizontalDraw.new(["2", "5", "3", "D"])
    assert_nil cmd.err, "This is a valid arguments."
  end

  def test_if_it_works
    bitmap_array = BitmapArray.new
    cmd = HorizontalDraw.new(["4", "2", "3", "A"])
    err = cmd.execute_on(bitmap_array)
    assert nil != err, "err object should exist if horizontal draw is called in empty bitmap-array. Create should be called first."

    cmd = Create.new(["5", "6"])
    cmd.execute_on(bitmap_array)
    cmd = HorizontalDraw.new(["1", "5", "2", "A"])
    err = cmd.execute_on(bitmap_array)

    assert_nil err, "err object must be nil"
    assert_equal "A", bitmap_array[2][1], "Pixel (1,2) must be coloured with A"
    assert_equal "A", bitmap_array[2][2], "Pixel (2,2) must be coloured with A"
    assert_equal "A", bitmap_array[2][3], "Pixel (3,2) must be coloured with A"
    assert_equal "A", bitmap_array[2][4], "Pixel (4,2) must be coloured with A"
    assert_equal "A", bitmap_array[2][5], "Pixel (5,2) must be coloured with A"
    assert_nil bitmap_array[2][6], "Pixel (6,2) is nil"
    assert_equal "O", bitmap_array[1][3], "Pixel (1,3) must have default O"
  end
end
