require './lib/bitmap_array'

require './lib/command'
require './lib/commands/create'
require './lib/commands/set_pixel'
require './lib/commands/vertical_draw'
require './lib/commands/horizontal_draw'
require './lib/commands/show'

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
      raise_error "Error: [line:#{line_number+1}]:: Invalid command: #{cmd.to_string}" if cmd.klass.nil?
      raise_error "Error: [line:#{line_number+1}]:: #{cmd.to_string} not defined" unless Object.const_defined?(cmd.klass)

      command = Object.const_get(cmd.klass).new(cmd.args)
      raise_error "Error: [line:#{line_number+1}]:: #{command.err.error}" unless command.err.nil?

      err = command.execute_on(@output)
      if err.is_a?(BitmapException)
        puts "#{err.level}: [line:#{line_number+1}]:: #{err.error}"
        exit if err.level == BitmapException::ERROR
      end
    end
    true
  end

  def size
    @list.size
  end

  private
  def raise_error(msg)
    puts msg
    exit
  end
end
