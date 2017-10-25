require './lib/bitmap_array'

require './lib/command'
require './lib/commands/create'
require './lib/commands/set_pixel'

require './lib/bitmap_exception'

class Commands
  attr_reader :output

  def initialize
    @list = []
    @output = BitmapArray.new
  end

  def append(command)
    raise "argument must be a Command." unless command.is_a?(Command)
    @list << command
  end

  def execute
    @list.each_with_index do |cmd, line_number|
      raise "[line:#{line_number+1}]:: invalid command: #{cmd.to_string}" if cmd.klass.nil?
      raise "[line:#{line_number+1}]:: #{cmd.to_string} not defined" unless Object.const_defined?(cmd.klass)

      command = Object.const_get(cmd.klass).new(cmd.args)
      unless command.err.nil?
        puts "ERROR: [line:#{line_number+1}]:: #{command.err.error}"
        raise
      end

      err = command.execute_on(@output)
      if err.is_a?(BitmapException)
        puts "#{err.level}: [line:#{line_number+1}]:: #{err.error}"
        raise if err.level == BitmapException::ERROR
      end
    end
    true
  end

  def size
    @list.size
  end
end
