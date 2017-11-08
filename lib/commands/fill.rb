require './lib/bitmap_array'
require './lib/bitmap_exception'

require './utils/string'

class Fill
  attr_reader :err

  include Utils::String

  def initialize(args)
    @x, @y, @colour, @err = get_parameters(args)
  end

  def execute_on(bitmap_array)
    err = BitmapException.new(BitmapException::ERROR, "Couldn't call Fill Command before create().") if bitmap_array.length == 0
    return err unless err.nil?

    err = BitmapException.new(BitmapException::ERROR, "Pixel out-of-bound error.") if @x > bitmap_array.length || @y > bitmap_array.height
    return err unless err.nil?

    fill(@x, @y, bitmap_array.color_of(@x, @y), @colour, bitmap_array)
    nil
  end

  private
  def get_parameters(args)
    err = BitmapException.new(BitmapException::ERROR, "Invalid arguments `#{args}`") if !args.is_a?(Array)
    return nil, nil, nil, err unless err.nil?

    err = BitmapException.new(BitmapException::ERROR, "Expected to have 3 arguments but instead got #{args.length}") if args.length != 3
    return nil, nil, nil, err unless err.nil?

    invalid = ((!is_integer?(args[0]) || (args[0].to_i < 1 || args[0].to_i > 250)) || (!is_integer?(args[1]) || (args[1].to_i < 1 || args[1].to_i > 250)) || !is_colour?(args[2]))
    err = BitmapException.new(BitmapException::ERROR, "Invalid argument type. Arguments should be (integer, integer, string) where 1<integer<250") if invalid
    return nil, nil, nil, err unless err.nil?

    x = args[0].to_i
    y = args[1].to_i
    c = args[2]

    return x, y, c, nil
  end

  def fill(x, y, color_old, color_new, bitmap_array)
    return unless !bitmap_array.index_out_of_range?(x, y) && bitmap_array.color_of(x, y) == color_old
    bitmap_array[y][x] = color_new
    fill(x+1, y, color_old, color_new, bitmap_array)
    fill(x-1, y, color_old, color_new, bitmap_array)
    fill(x, y+1, color_old, color_new, bitmap_array)
    fill(x, y-1, color_old, color_new, bitmap_array)
    fill(x+1, y+1, color_old, color_new, bitmap_array)
    fill(x-1, y+1, color_old, color_new, bitmap_array)
    fill(x+1, y-1, color_old, color_new, bitmap_array)
    fill(x-1, y+1, color_old, color_new, bitmap_array)
  end
end
