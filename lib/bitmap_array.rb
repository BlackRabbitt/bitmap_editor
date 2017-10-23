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
    @matrix[0].length
  end

  def print
    for i in 0...rows
      puts @matrix[i]
    end
  end

  alias_method :length, :rows
  alias_method :breadth, :cols
end
