require './lib/command'

class Parser
  def initialize; end

  def self.parse(line)
    tokens = line.split(" ")
    Command.new(tokens[0], tokens[1..-1])
  end
end
