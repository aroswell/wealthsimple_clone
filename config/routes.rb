# Routes for application
require File.expand_path("../../app/controllers/dashboard_controller", __FILE__)

set :views, File.expand_path("../../app/views", __FILE__)

before do
  puts "Before filter"
  puts "[params] = #{params}"
  puts "app = #{app}"
  puts "request = #{request}"
  # puts "env = #{env}"
  puts "response = #{response}"
  puts "template cache = #{template_cache}"
end

# Dashboard routing
get '/' do
  @string = Dashboard.index(params)
  erb :index
end