require './lib/bitmap_array'
require './lib/bitmap_exception'

require './utils/string'
require 'pry'

class SetPixel
  attr_reader :err

  include Utils::String

  def initialize(args)
    @x, @y, @colour, @err = get_parameters(args)
  end

  # execute command on bitmap_array_matrix with args
  def execute_on(bitmap_array)
    err = BitmapException.new(BitmapException::ERROR, "Couldn't call SetPixel in empty bitmap. Use create() command to create bitmap.") if bitmap_array.length == 0
    return err unless err.nil?

    bitmap_array[@x][@y] = @colour

    nil
  end

  private
  def get_parameters(args)
    err = BitmapException.new(BitmapException::ERROR, "Invalid arguments `#{args}`") if !args.is_a?(Array)
    return nil, nil, nil, err unless err.nil?

    err = BitmapException.new(BitmapException::ERROR, "Expected to have 3 arguments but instead got #{args.length}") if args.length != 3
    return nil, nil, nil, err unless err.nil?

    invalid = ((!is_integer(args[0]) || (args[0].to_i < 1 || args[0].to_i > 250)) || (!is_integer(args[1]) || (args[1].to_i < 1 || args[1].to_i > 250)) ||is_integer(args[2]))
    err = BitmapException.new(BitmapException::ERROR, "Invalid argument type. Arguments should be (integer, integer, string) where 1<integer<250") if invalid
    return nil, nil, nil, err unless err.nil?

    x = args[0].to_i
    y = args[1].to_i
    c = args[2]
    return x, y, c, nil
  end
end
