require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models'
require './src/signin-up-out'

require './src/time'

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
  @time = Time.now
  pomodoro = current_user.pomodoros.create(
    time: 0,
    start: @time.timezone('Asia/Tokyo')
  )
  erb :timer
end

post '/pJsDQTKCQSepB8AzkcPmNcEm88VSzwKx' do
  @time = Time.now
  pomodoro = current_user.pomodoros.last.update(
    time: params[:time],
    stop: @time.timezone('Asia/Tokyo')
  )
end

get '/nwnSEUmMbH9L5E3JvJX4WcznifBrZanN' do
  pomodoro = current_user.pomodoros.last.destroy
  redirect '/'
end

get '/interval' do
  erb :interval
end

post '/tQQBu3FNVhG2AKRv4G9aRRuiqc4nWbmx' do
  pomodoro = current_user.pomodoros.last.update(
    did: params[:did],
    understand: params[:understand],
    next: params[:next]
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