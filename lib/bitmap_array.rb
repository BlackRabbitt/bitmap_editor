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
