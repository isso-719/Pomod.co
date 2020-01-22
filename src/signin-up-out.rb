get '/signup' do
  if session[:user]
    'You are logged in.'
  else
    erb :signup
  end
end

post '/signup' do
  if params[:username] == ""
    session[:signup_error] = '入力してください'
    redirect '/signup'
  elsif params[:password] == ""
  session[:signup_error] = '入力してください'
  redirect '/signup'
  end
  if User.where({username: params[:username]}).count != 0
    session[:signup_error] = 'すでにこの名前は登録済みです'
    redirect '/signup'
  end
  if params[:password] != params[:password_confirmation]
    session[:signup_error] = 'パスワードが間違っています'
    redirect '/signup'
  end
  @user = User.create(
    username: params[:username],
    password: params[:password],
    password_confirmation: params[:password_confirmation])
  session[:signup_error] = nil
  if @user.persisted?
    session[:user] = @user.id
  end
  redirect '/'
end

get '/signin' do
  if session[:user]
    'You are logged in.'
  else
    erb :signin
  end
end

post '/signin' do
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  else
    session[:signin_error] = 'パスワードが間違っています'
    redirect '/signin'
  end
  redirect '/'
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end