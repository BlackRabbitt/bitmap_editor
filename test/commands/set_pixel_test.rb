require 'minitest/autorun'

require './lib/commands/set_pixel'
require './lib/bitmap_array'

class SetPixelTest < MiniTest::Test
  def test_if_exists
    cmd = SetPixel.new(["2", "5", "A"])
    assert_kind_of SetPixel, cmd
  end
end
