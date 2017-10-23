require 'minitest/autorun'

require './lib/parser.rb'
require './lib/command.rb'

class ParserTest < MiniTest::Test
  def test_if_it_parse_command
    command = Parser.parse("I 5 6")
    assert_kind_of Command, command
  end
end
