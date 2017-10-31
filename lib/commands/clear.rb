require './lib/bitmap_array'
require './lib/bitmap_exception'

require './utils/string'

class Clear
  attr_reader :err

  include Utils::String

  def initialize(args=[])
    @err = get_parameters(args)
  end

  # execute command on bitmap_array_matrix with args
  def execute_on(bitmap_array)
    err = BitmapException.new(BitmapException::ERROR, "Couldn't call Show Command before create() command.") if bitmap_array.length == 0
    return err unless err.nil?

    for i in 1..bitmap_array.height
      for j in 1..bitmap_array.length
        bitmap_array[i][j] = 'O'
      end
    end

    nil
  end

  def get_parameters(args)
    err = BitmapException.new(BitmapException::ERROR, "Invalid arguments `#{args}`") if !args.is_a?(Array)
    return err unless err.nil?

    err = BitmapException.new(BitmapException::ERROR, "Expected to have 0 arguments but instead got #{args.length}") if args.length != 0
    return err unless err.nil?
  end
end
