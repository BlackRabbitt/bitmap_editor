require './lib/application'

args = Hash[ ARGV.flat_map{|s| s.scan(/-?([^=\s]+)(?:=(\S+))?/) } ]

if args.key?('h')
  puts "example: ruby bitmap_editor.rb -f=<file_path>"
else
  # take file as input and run the application
  app = Application.new(args['f'])
  app.run()
end
