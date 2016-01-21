require "sinatra"
require "thin"
require 'tilt/erb'
# require 'rerun'

require File.expand_path("../../config/initializers/setup_env", __FILE__)
require File.expand_path("../../config/routes", __FILE__)

