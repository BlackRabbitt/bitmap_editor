require 'minitest/autorun'

require './lib/commands/vertical_draw'
require './lib/commands/create'

require './lib/bitmap_array'

class VerticalDrawTest < MiniTest::Test
  def test_if_exists
    cmd = VerticalDraw.new(["2", "5", "6", "A"])
    assert_kind_of VerticalDraw, cmd
  end

  def test_if_it_handles_invalid_arguments
    cmd = VerticalDraw.new("This should not valid")
    assert nil != cmd.err, "err object should exist for non-array parameter."

    cmd = VerticalDraw.new(["A", "1", "B", "A"])
    assert nil != cmd.err, "err object should exist for 1 non-permitted arguments"

    cmd = VerticalDraw.new(["2", "4", "B", "2"])
    assert nil != cmd.err, "err object should exist for 2 non-permitted arguments"

    cmd = VerticalDraw.new(["2", "4", "3", "1"])
    assert nil != cmd.err, "err object should exist for 3 non-permitted arguments"

    cmd = VerticalDraw.new(["0", "2", "3", "A"])
    assert nil != cmd.err, "err object should exist if the arguments is smaller than 1"

    cmd = VerticalDraw.new(["2", "1", "255", "B"])
    assert nil != cmd.err, "err object should exist if the arguments is greater than 250"

    cmd = VerticalDraw.new(["1", "3", "4", "X", "Y"])
    assert nil != cmd.err, "err object should exist if it has extra arguments."

    cmd = VerticalDraw.new(["1", "4", "3", "X"])
    assert nil != cmd.err, "err object should exist if y2 < y1."

    cmd = VerticalDraw.new(["250", "1", "3", "D"])
    assert_nil cmd.err, "This is a valid arguments."
  end

  def test_if_it_works
    bitmap_array = BitmapArray.new
    cmd = VerticalDraw.new(["4", "2", "3", "A"])
    err = cmd.execute_on(bitmap_array)
    assert nil != err, "err object should exist if set_pixel is called in empty bitmap-array. Create should be called first."

    cmd = Create.new(["5", "6"])
    cmd.execute_on(bitmap_array)
    cmd = VerticalDraw.new(["2", "1", "5", "A"])
    err = cmd.execute_on(bitmap_array)

    assert_nil err, "err object must be nil"
    assert_equal "A", bitmap_array[1][2], "Pixel (2,1) must be coloured with A"
    assert_equal "A", bitmap_array[2][2], "Pixel (2,2) must be coloured with A"
    assert_equal "A", bitmap_array[3][2], "Pixel (2,3) must be coloured with A"
    assert_equal "A", bitmap_array[4][2], "Pixel (2,4) must be coloured with A"
    assert_equal "A", bitmap_array[5][2], "Pixel (2,5) must be coloured with A"
    assert_equal "0", bitmap_array[6][2], "Pixel (2,6) must be coloured with 0"
    assert_equal "0", bitmap_array[2][1], "Pixel (1,2) must have default 0"
  end
end
