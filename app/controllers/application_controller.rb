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
      User.find(session[:dep_id]) if session[:dep_id]
    end

    def logged_in?
        !!current_user
    end

    def authentication_required
        if !logged_in?
            flash[:authenticate_error] = '* You must log in.'
            redirect '/'
        end
    end
  end
end
