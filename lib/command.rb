class Command
  attr_reader :args

  def initialize(cmd, args)
    @cmd = cmd
    @args = args
  end

  def klass
    {
      I: "Create",
      C: "Clear",
      L: "SetPixel",
      V: "VerticalDraw",
      H: "HorizontalDraw",
      S: "Show",
      F: "Fill"
    }[@cmd.to_sym]
  end

  def to_string
    @cmd
  end
end
