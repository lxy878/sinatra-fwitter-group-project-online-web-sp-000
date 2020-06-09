require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable  :sessions
    set :session_secret, 'sometHing_noT_tO_tEll'
  end

  get '/' do
    erb :'index'
  end
  helpers do
    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user
    end

    def authentication_required
        redirect '/login' if !logged_in?
    end
  end

  get '/signup' do
    if logged_in?
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
    if logged_in?
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
      redirect '/login'
    end

  end

  get '/logout' do
    if !logged_in?
      redirect '/'
    end
    session.clear
    redirect '/login'
  end
end
