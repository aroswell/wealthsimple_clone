require File.expand_path("../../config/initializers/setup_env", __FILE__)
# require 'bundler/setup'
# Bundler.require(:default)
active_record = require "active_record"
pg = require "pg"
logger = require "logger"
faker = require 'faker'
bcrypt = require 'bcrypt'
cucumber = require 'cucumber'

unless active_record
  puts "loading error for active_record lib"
end

unless pg
  puts "loading error for pg lib"
end

unless logger
  puts "loading error for logger lib"
end

unless faker
  puts "loading error for faker lib"
end

unless bcrypt
  puts "loading error for bcrypt lib"
end

