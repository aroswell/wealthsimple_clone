sinatra  = require "sinatra"
thin = require "thin"


get '/' do
  'Hello world!'
end