require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

require 'date'
require 'time'

# require 'kaminari'
require 'sinatra'
require 'padrino-helpers'
require 'kaminari/sinatra'

enable :sessions

helpers Kaminari::Helpers::SinatraHelpers

helpers do

  def current_user
    User.find_by(id: session[:user])
  end

  def now_date
    Date.today
  end

end

get '/' do

  if session[:user]

    @all_tomatoes = current_user.tomatoes.where.not(tomato_start_datetime: "", tomato_end_datetime: "",role: false).count

    @week_tomatoes = current_user.tomatoes.where("created_at > ?", 1.weeks.ago).where.not(tomato_start_datetime: "", tomato_end_datetime: "",role: "0").count

    if @week_tomatoes >= current_user.goal

      @goal_tomatoes = 100

      @goal = 0

    else

      @goal_tomatoes = ((@week_tomatoes.to_f/current_user.goal) * 100).round(2)

      @goal = 100-@goal_tomatoes

    end

  end

  erb :index

end

before '/login' do

    if session[:user]
    redirect '/login'
  end

end

get '/login' do

  erb :login
end

post '/login' do

  user = User.find_by(mail: params[:mail])
  if user && user.authenticate(params[:password])
    session[:user] = user.id

  else
    redirect'/login'

  end

  redirect '/'
end

before '/logout' do

    unless session[:user]
    redirect '/login'
  end

end

get '/logout' do

  session[:user] = nil

  redirect '/'
end

before '/signup' do

    if session[:user]
    redirect '/login'
  end

end

get '/signup' do

  erb :signup
end

post '/signup' do
  @user = User.create(
    name:params[:name],
    mail:params[:mail],
    password:params[:password],
    password_confirmation:params[:password_confirmation])

  if @user.persisted?
    session[:user] = @user.id

    redirect '/'
  else
    redirect '/signup'
  end


end

before '/history' do

  unless session[:user]
    redirect '/login'
  end

end

get '/history' do

  @tomatoes = Kaminari.paginate_array(current_user.tomatoes.where.not(tomato_start_datetime: "", tomato_end_datetime: "")).page(params[:page]).per(5)

  erb :history
end

post '/history/:id' do

  @tomato = current_user.tomatoes.find(params[:id])

  erb :history_update
end

post '/history/:id/update' do
  @tomato = current_user.tomatoes.find(params[:id])
  @tomato.update({
    topic: params[:topic],
    memo: params[:memo]
  })

  redirect '/history'
end

# before '/timer' do

#     if session[:user]
#     redirect '/timer'
#   end

# end

get '/timer' do

  erb :timer
end

before '/account' do

  unless session[:user]
    redirect '/login'
  end

end

get '/account' do

  user = User.find_by(id: session[:user])


  erb :account
end

post '/account/timer/timer' do

  user = User.find_by(id: session[:user])
  user.user_timer_mode = "timer"
  user.save

  redirect '/account'

end

post '/account/timer/tomato' do

  user = User.find_by(id: session[:user])
  user.user_timer_mode = "tomato"
  user.save

  redirect '/account'

end

post '/account/update/goal' do

  User.find_by(id: session[:user]).update({
    goal: params[:goal]
  })

  redirect '/account'

end

post '/account/update/general' do

  User.find_by(id: session[:user]).update({
    name: params[:name],
    mail: params[:mail]
  })

  redirect'/account'

end

post '/account/update/password' do

  User.find_by(id: session[:user]).update({
    password:params[:password],
    password_confirmation:params[:password_confirmation]
  })

  redirect '/account'

end

post '/account/reset' do

  @tomatoes = current_user.tomatoes.where.not(tomato_start_datetime: "", tomato_end_datetime: "")
  @tomatoes.destroy_all

  redirect '/account'
end

post '/account/delete' do

  current_user.destroy
  session[:user] = nil

  redirect '/'


end

post '/icon/shuffle' do

  user = User.find_by(id: session[:user])
  user.user_gravatar = SecureRandom.hex(32)
  user.save

  redirect '/account'

end

post '/icon/delete' do

  user = User.find_by(id: session[:user])
  user.user_icon.destoroy

  redirect '/account'

end

post '/z1DNLiBUvP' do

  time = Time.now.getutc + 9 * 60 * 60

  tomato = User.find_by(id: session[:user]).tomatoes.create
  tomato.tomato_start_datetime = time.strftime("%Y/%m/%d %H:%M:%S JST")
  tomato.save


  redirect'/'

end

post '/y1DNKiBUvP' do

  time = Time.now.getutc + 9 * 60 * 60

  tomato = User.find_by(id: session[:user]).tomatoes.last
  tomato.tomato_end_datetime = time.strftime("%Y/%m/%d %H:%M:%S JST")
  tomato.save


  redirect'/'

end

post '/z3FNLiDUvQ' do

  time = Time.now.getutc + 9 * 60 * 60

  tomato = User.find_by(id: session[:user]).tomatoes.last
  tomato.role = !tomato.role
  tomato.tomato_end_datetime = time.strftime("%Y/%m/%d %H:%M:%S JST")
  tomato.save


  redirect'/'

end

get '/interval' do

  @tomato = User.find_by(id: session[:user]).tomatoes.last

erb :interval

end

post '/interval/post' do

  User.find_by(id: session[:user]).tomatoes.last.update({
    topic: params[:topic],
    memo: params[:memo]
  })

  redirect'/'

end