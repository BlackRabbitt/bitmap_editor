require './lib/bitmap_array'
require './lib/bitmap_exception'

class SetPixel
  attr_reader :err

  def initialize(args)
    @args = args
  end

  # # execute command on bitmap_array_matrix with args
  # def execute_on(bitmap_array)
  #   return BitmapException.new(BitmapException::ERROR, "Expected to have 3 arguments but instead got #{@args.length}") if @args.length != 3

  #   for i in 1..length
  #     for j in 1..breadth
  #       bitmap_array[i][j]="0"
  #     end
  #   end

  #   return BitmapException.new(BitmapException::WARN, "Create command called twice.") unless bitmap_array.length > 0
  # end
end
