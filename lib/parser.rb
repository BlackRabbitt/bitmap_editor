require 'command.rb'

class Parser
  def initialize

  end

  def parse(filename)
    File.open(filename, "r") do |f|
      f.each_line do |line|
        cmd = Command.new(line)
        cmd.execute()
      end
    end
  end
end
