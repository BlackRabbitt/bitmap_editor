require './lib/parser'
require './lib/commands'

class Application
  def initialize(filepath)
    return puts "No input file error" if filepath.nil?
    @file = filepath
  end

  def run()
    return puts "please provide correct file" if @file.nil? || !File.exists?(@file)
    File.open(@file, "r") do |f|
      commands = Commands.new
      f.each_line do |line|
        commands.append(Parser.parse(line))
      end
      commands.execute
    end
  end
end
