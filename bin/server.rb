require "sinatra"
require "thin"
require 'tilt/erb'
require 'rerun' unless ENV["RACK_ENV"] == "production"

require File.expand_path("../../config/initializers/setup_env", __FILE__)
require File.expand_path("../../config/routes", __FILE__)

