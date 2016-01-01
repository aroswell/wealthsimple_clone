require "sinatra"
require "thin"
require 'tilt/erb'
require 'rerun'

require File.expand_path("../../config/initializers/setup_env", __FILE__)

# these next two lines break the sinatra!!
# puts "Next two lines kill code"
# require 'bundler/setup'
# Bundler.require(:default)


require File.expand_path("../../config/routes", __FILE__)

