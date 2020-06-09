class TweetsController < ApplicationController
  before '/tweet*' do
    authentication_required
  end
  
  get '/tweets' do
    @user = current_user
    erb :'tweets/tweets'
  end


end
