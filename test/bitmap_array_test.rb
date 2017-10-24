require 'minitest/autorun'
require './lib/bitmap_array.rb'

class BitmapArrayTest < MiniTest::Test
  def test_if_exists
    bat = BitmapArray.new
    assert_kind_of BitmapArray, bat
    assert 0, bat.length
  end

  def test_if_can_use_bitmap_array
    bat = BitmapArray.new
    bat[0][0]="I"
    bat[0][1]="5"
    bat[0][2]="6"

    assert 1, bat.length
    assert 3, bat.height

    assert "6", bat[0][2]
  end
end
