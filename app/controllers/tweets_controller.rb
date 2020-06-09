class TweetsController < ApplicationController
  before '/tweet*' do
    authentication_required
  end

  get '/tweets' do
    @user = current_user
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do

  end
end
