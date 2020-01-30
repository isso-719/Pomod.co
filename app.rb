require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models'
require './src/signin-up-out'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user])
  end
end


get '/' do
  # ユーザー未ログイン時
  unless session[:user]
    erb :index_sign_off

  # ユーザーログイン時
  else
    user = current_user
    erb :index_sign_on
  end
end

get '/timer_set' do
    # ユーザー未ログイン時
  unless session[:user]
    redirect '/'

  # ユーザーログイン時
  else
    erb :timer_set
  end
end

get '/timer' do
  pomodoro = current_user.pomodoros.create(
    time: 0
  )
  erb :timer
end

post '/pJsDQTKCQSepB8AzkcPmNcEm88VSzwKx' do
  pomodoro = current_user.pomodoros.last.update(
    time: params[:time]
  )
end

get '/chart' do
  erb :chart
end

get '/todo' do
  erb :todo
end

get '/settings' do
  erb :settings
end