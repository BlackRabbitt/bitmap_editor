require './lib/parser'
require './lib/commands'

class Application
  def initialize(filepath)
    raise "No input file error" if filepath.nil?
    @filepath = filepath
  end

  def run()
    File.open(@filepath, "r") do |f|
      commands = Commands.new
      f.each_line do |line|
        commands.append(Parser.parse(line))
      end
      commands.execute
      commands.output
    end
  end
end
