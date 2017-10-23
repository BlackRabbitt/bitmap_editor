class BitmapException
  attr_reader :level, :error

  ERROR="Error"
  WARN="Warning"

  def initialize(level, error)
    @level = level
    @error = error
  end
end
