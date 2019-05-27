require 'bundler'
require "open-uri"
require "json"

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_relative '../app/functions.rb'
