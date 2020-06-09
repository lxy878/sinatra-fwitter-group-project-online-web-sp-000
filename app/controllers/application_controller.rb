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
    def login?
      session.has_key?(:user_id)
    end
  end
end
