require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models'

enable :sessions

get '/' do
  erb :index
end