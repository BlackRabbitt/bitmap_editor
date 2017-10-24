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
    for i in 1..@height
      for j in 1..@length
        bitmap_array[i][j]="0"
      end
    end
    return BitmapException.new(BitmapException::WARN, "Create command called twice.") unless bitmap_array.length > 0
  end

  private
  def get_parameters(args)
    err = BitmapException.new(BitmapException::ERROR, "Invalid arguments `#{args}`") if !args.is_a?(Array)
    unless err.nil?
      return nil, nil, err
    end

    err = BitmapException.new(BitmapException::ERROR, "Expected to have 2 arguments but instead got #{args.length}") if args.length != 2
    unless err.nil?
      return nil, nil, err
    end

    args.each_with_index do |a, i|
      err = BitmapException.new(BitmapException::ERROR, "Invalid #{a}. Position-#{i+1} argument must be integer and should range from 1-250") if (!is_integer(a) && (a.to_i < 1 || a.to_i > 250))
      unless err.nil?
        return nil, nil, err
      end
    end

    m = args[0].to_i
    n = args[1].to_i
    return m, n, nil
  end
end
