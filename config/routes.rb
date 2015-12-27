# Routes for application

set :views, File.expand_path("../../app/views", __FILE__)

get '/' do
  puts params
  erb :index
end