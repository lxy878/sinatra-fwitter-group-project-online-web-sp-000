class UsersController < ApplicationController
  get '/signup' do
    if session.has?(:user_id)
    erb :'users/create_user'
  end
end
