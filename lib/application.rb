require './parser.rb'

class Application
  def initialize(filepath)
    raise "No input file error" if filepath.nil?
    @filepath = filepath
    @parser = Parser.new
  end

  def run()
    File.open(@filepath, "r") do |f|
      f.each_line do |line|
        cmd, args = @parser.parse(line)
        cmd.execute(args)
      end
    end
  end
end
