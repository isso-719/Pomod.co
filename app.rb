require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models'
require './src/signin-up-out'
require './src/time'
require './src/progress-bar'

require 'will_paginate/view_helpers/sinatra'
require 'will_paginate/active_record'
require 'will_paginate/array'

helpers WillPaginate::Sinatra

enable :sessions
set :sessions, :expire_after => 2592000

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
    # './src/progress-bar'
    progress_bar_today

    @notices = Notice.limit(5)
    erb :index_sign_on
  end
end

post '/set_goal' do
  goal = current_user.user_settings.create(
    goal: params[:goal]
  )
end

get '/about' do
  erb :about
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
  #'./src/progress-bar'
  progress_bar_today
  progress_bar_week

  @array = []
  today = Date.today
  [*(0..6)].reverse_each do |i|

    if current_user.pomodoros.find_by(updated_at: i.days.ago.all_day).nil?
      @array.push(0)
    else
      @array.push(current_user.pomodoros.where(updated_at: i.days.ago.all_day).sum(:time) / 60)
    end

  end

  if current_user.pomodoros.find_by("time > ?", 0).nil?
    @histories = nil
  else
    @histories = current_user.pomodoros.where("time > ?", 0).reverse.paginate(:page => params[:page], :per_page => 5)
  end

  erb :chart
end

post '/chart/edit/:id' do
  @pomodoro = current_user.pomodoros.find(params[:id])
  erb :chart_edit
end

get '/todo' do
  erb :todo
end

get '/settings' do
  erb :settings
end

get '/administrator' do
  erb :administrator
end

post '/administrator' do
  if params[:user] == 'administrator' && params[:password] == 'cai'
    erb :manage
  else
    redirect '/'
  end
end

post '/make_notice' do
    @notice = Notice.create(
    title: params[:title],
    content: params[:content])
  erb :manage
end