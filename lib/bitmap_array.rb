# two-dimensional array where 1st dimension is height and second dimension is length
# for example pixel(1, 2) is represented as bitmap_array[2][1] <= height first and then length
class BitmapArray
  def initialize
    @matrix = {}
  end

  def [](key)
    @matrix[key] ||= {}
  end

  def rows
    @matrix.length
  end

  def cols
    if rows == 0
      0
    else
      @matrix.values.first.length
    end
  end

  def print
    for i in 1..rows
      puts @matrix[i]
    end
  end

  alias_method :height, :rows
  alias_method :length, :cols
end
