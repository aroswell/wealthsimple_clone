require "sinatra"
require "thin"
require 'tilt/erb'
require 'rerun'
require File.expand_path("../../config/routes", __FILE__)
