require_relative '../config/environment'
require_all 'lib'
require 'pry'
require 'tty-prompt'



new_session = Cli.new
new_session.run
# puts "HELLO WORLD"