require 'minitest/autorun'
require './lib/bitmap_array.rb'

class BitmapArrayTest < MiniTest::Test
  def test_if_exists
    bat = BitmapArray.new
    assert_kind_of BitmapArray, bat
    assert bat.length, 0
  end

  def test_if_can_use_bitmap_array
    bat = BitmapArray.new
    bat[0][0]="I"
    bat[0][1]="5"
    bat[0][2]="6"

    assert bat.length, 1
    assert bat.breadth, 3
  end
end
