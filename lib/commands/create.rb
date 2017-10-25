require './lib/bitmap_array'
require './lib/bitmap_exception'
require './utils/string'

class Create
  attr_reader :err

  include Utils::String

  def initialize(args=[])
    @length, @height, @err = get_parameters(args)
  end

  # execute command on bitmap_array_matrix with args
  def execute_on(bitmap_array)
    err = BitmapException.new(BitmapException::WARN, "Create command called twice.") if bitmap_array.length > 0
    return err unless err.nil?

    for i in 1..@height
      for j in 1..@length
        bitmap_array[i][j]="0"
      end
    end

    nil
  end

  private
  def get_parameters(args)
    err = BitmapException.new(BitmapException::ERROR, "Invalid arguments `#{args}`") if !args.is_a?(Array)
    return nil, nil, err unless err.nil?

    err = BitmapException.new(BitmapException::ERROR, "Expected to have 2 arguments but instead got #{args.length}") if args.length != 2
    return nil, nil, err unless err.nil?

    args.each_with_index do |a, i|
      err = BitmapException.new(BitmapException::ERROR, "Invalid #{a}. Position-#{i+1} argument must be integer and should range from 1-250") if (!is_integer?(a) && (a.to_i < 1 || a.to_i > 250))
      return nil, nil, err unless err.nil?
    end

    m = args[0].to_i
    n = args[1].to_i
    return m, n, nil
  end
end
