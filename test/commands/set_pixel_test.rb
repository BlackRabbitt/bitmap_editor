require 'minitest/autorun'

require './lib/commands/set_pixel'
require './lib/commands/create'

require './lib/bitmap_array'

class SetPixelTest < MiniTest::Test
  def test_if_exists
    cmd = SetPixel.new(["2", "5", "A"])
    assert_kind_of SetPixel, cmd
  end

  def test_if_it_handles_invalid_arguments
    cmd = SetPixel.new("This should not valid")
    assert nil != cmd.err, "err object should exist for non-array parameter create create command."

    cmd = SetPixel.new(["A", "B", "A"])
    assert nil != cmd.err, "err object should exist for 1 non-permitted arguments for create command"

    cmd = SetPixel.new(["2", "4", "2"])
    assert nil != cmd.err, "err object should exist for 2 non-permitted arguments for create command"

    cmd = SetPixel.new(["A", "4", "A"])
    assert nil != cmd.err, "err object should exist for 3 non-permitted arguments for create command"

    cmd = SetPixel.new(["0", "0", "A"])
    assert nil != cmd.err, "err object should exist if the arguments is smaller than 1"

    cmd = SetPixel.new(["1", "255", "B"])
    assert nil != cmd.err, "err object should exist if the arguments is greater than 250"

    cmd = SetPixel.new(["1", "3", "4", "X"])
    assert nil != cmd.err, "err object should exist if it has extra arguments."

    cmd = SetPixel.new(["250", "1", "D"])
    assert_nil cmd.err, "This is a valid arguments."
  end

  def test_if_it_works
    bitmap_array = BitmapArray.new
    cmd = SetPixel.new(["4", "2", "A"])
    err = cmd.execute_on(bitmap_array)
    assert nil != err, "err object should exist if set_pixel is called in empty bitmap-array. Create should be called first."

    cmd = Create.new(["3", "2"])
    cmd.execute_on(bitmap_array)
    cmd = SetPixel.new(["2", "1", "A"])
    err = cmd.execute_on(bitmap_array)

    assert_nil err, "err object must be nil"
    assert_equal "A", bitmap_array[2][1], "Pixel (2,1) must be coloured with A"
    assert_equal "0", bitmap_array[1][2], "Pixel (1,2) must have default 0"

    cmd = SetPixel.new(["4", "1", "B"])
    err = cmd.execute_on(bitmap_array)
    assert nil != err, "err object should exist for pixel out-of-bound error. Trying to set colour in pixel that doesnot exist"

    cmd = SetPixel.new(["2", "4", "B"])
    err = cmd.execute_on(bitmap_array)
    assert nil != err, "err object should exist for pixel out-of-bound error. Trying to set colour in pixel that doesnot exist"
  end
end
