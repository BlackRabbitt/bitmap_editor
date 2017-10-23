require 'minitest/autorun'

require './lib/commands.rb'
require './lib/command.rb'

class CommandsTest < MiniTest::Test
  def test_if_exists
    commands = Commands.new
    assert_kind_of Commands, commands
  end

  def test_if_can_append_command_to_commands
    commands = Commands.new
    assert commands.size, 0

    commands.append(Command.new("I", ["2", "4"]))
    assert commands.size, 1
  end

  def test_if_will_append_only_command
    commands = Commands.new
    assert_raises(Exception) {commands.append(Dumb.new)}
  end

  def test_if_commands_executes_in_order
    commands = setup_commands
    assert commands.execute
  end

  private
  def setup_commands
    commands = Commands.new
    commands.append(Command.new("I", ["2", "4"]))
    commands.append(Command.new("L", ["1", "3", "A"]))
    return commands
  end
end

class Dumb; end
