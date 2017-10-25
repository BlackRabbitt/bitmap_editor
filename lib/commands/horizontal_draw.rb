require './lib/bitmap_array'
require './lib/bitmap_exception'

require './utils/string'

class HorizontalDraw
  attr_reader :err

  include Utils::String

  def initialize(args)
    @x1, @x2, @y, @colour, @err = get_parameters(args)
  end

  def execute_on(bitmap_array)
    err = BitmapException.new(BitmapException::ERROR, "Couldn't call HorizontalDraw command before create().") if bitmap_array.length == 0
    return err unless err.nil?

    err = BitmapException.new(BitmapException::ERROR, "Pixel out-of-bound error.") if @x1 > bitmap_array.length || @x2 > bitmap_array.length || @y > bitmap_array.height
    return err unless err.nil?

    for x in @x1..@x2
      bitmap_array[@y][x] = @colour
    end
    nil
  end

  private
  def get_parameters(args)
    err = BitmapException.new(BitmapException::ERROR, "Invalid arguments `#{args}`") if !args.is_a?(Array)
    return nil, nil, nil, nil, err unless err.nil?

    err = BitmapException.new(BitmapException::ERROR, "Expected to have 4 arguments but instead got #{args.length}") if args.length != 4
    return nil, nil, nil, nil, err unless err.nil?

    invalid = ((!is_integer?(args[0]) || (args[0].to_i < 1 || args[0].to_i > 250)) || (!is_integer?(args[1]) || (args[1].to_i < 1 || args[1].to_i > 250)) || (!is_integer?(args[2]) || (args[2].to_i < 1 || args[2].to_i > 250)) || !is_colour?(args[3]))
    err = BitmapException.new(BitmapException::ERROR, "Invalid argument type. Arguments should be (integer, integer, string) where 1<integer<250") if invalid
    return nil, nil, nil, nil, err unless err.nil?

    x1 = args[0].to_i
    x2 = args[1].to_i
    y = args[2].to_i
    c = args[3]

    err = BitmapException.new(BitmapException::ERROR, "x2 parameter must be greater than x1 parameter") if x2 < x1
    return nil, nil, nil, nil, err unless err.nil?

    return x1, x2, y, c, nil
  end
end
