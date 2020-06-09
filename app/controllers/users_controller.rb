class UsersController < ApplicationController
  get '/signup' do
    if login?
      redirect '/tweets'
    end
    erb :'users/create_user'

  end

  post '/signup' do
    new_user = User.new(params)
    if new_user.username.empty? or new_user.email.empty? or !new_user.save
      redirect '/signup'
    end
    session[:user_id] = new_user.id
    redirect '/tweets'
  end

  get '/login' do
    if login?
      redirect '/tweets'
    end
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      'fail login'
    end

  end

  get 'logout' do
    redirect '/'
  end
end
