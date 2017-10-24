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
    assert 0, commands.size

    commands.append(Command.new("I", ["2", "4"]))
    assert 1, commands.size
  end

  def test_if_will_append_only_command
    commands = Commands.new
    assert_raises(Exception) {commands.append(Dumb.new)}
  end

  def test_if_commands_executes_in_order
    commands = setup_test_commands_1
    assert commands.execute, "Commands Execution Test Failed."
  end

  private
  def setup_test_commands_1
    commands = Commands.new
    commands.append(Command.new("I", ["2", "4"]))
    commands.append(Command.new("L", ["1", "3", "A"]))
    return commands
  end
end

class Dumb; end
