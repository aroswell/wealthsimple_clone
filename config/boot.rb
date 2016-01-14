require File.expand_path("../../config/initializers/setup_env", __FILE__)
# require 'bundler/setup'
# Bundler.require(:default)
active_record = require "active_record"
pg = require "pg"
logger = require "logger"
faker = require 'faker'
bcrypt = require 'bcrypt'

unless active_record
  puts "loading error for active_record lib"
  puts $LOAD_PATH
end

unless pg
  puts $LOAD_PATH
  puts "loading error for pg lib"
end

unless logger
  puts "loading error for logger lib"
  puts $LOAD_PATH
end

unless faker
  puts "loading error for faker lib"
  puts $LOAD_PATH
end

unless bcrypt
  puts "loading error for bcrypt lib"
  puts $LOAD_PATH
end

