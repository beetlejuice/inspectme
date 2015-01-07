require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'

configure :development do

  register Sinatra::Reloader

end

require './models/init'
require './routes/init'