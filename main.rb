require 'bundler/setup'
require 'sinatra'
require 'sinatra/contrib' if development?
require 'haml'

configure :development do
  register Sinatra::Reloader

  also_reload "models/*.rb"
  also_reload "views/*.rb"
  also_reload "classes/*.rb"
end

require './models/init'
require './routes/init'
require './classes/init'