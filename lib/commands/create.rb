require './lib/bitmap_array'
require './lib/bitmap_exception'

class Create
  def initialize(args)
    @args = args
  end

  # execute command on bitmap_array_matrix with args
  def execute_on(bitmap_array)
    return BitmapException.new(BitmapException::ERROR, "Expected to have 2 arguments but instead got #{@args.length}") if @args.length != 2

    length = @args[0].to_i # rows
    breadth = @args[1].to_i

    for i in 0...length
      for j in 0...breadth
        bitmap_array[i][j]="0"
      end
    end

    return BitmapException.new(BitmapException::WARN, "Create command called twice.") unless bitmap_array.length > 0
  end
end
