class Command
  attr_accessor :result

  def initialize(command)
    @result = @command_manager.execute(command)
  end
end
