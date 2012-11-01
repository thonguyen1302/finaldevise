class SessionsController < ApplicationController
  def index
    
  end

  def new
    
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end





  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end
  
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end




end