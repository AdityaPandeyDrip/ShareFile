class SessionsController < ApplicationController
  def new
    if session[:user_id] && User.find(session[:user_id])
      redirect_to '/'
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      current_user
      flash[:notice] = 'Login successful'
      redirect_to '/'
    else
      flash[:notice] = 'Invalid Email or Password'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged Out'
    redirect_to '/'
  end
end
