class UserController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      flash[:notice] = 'Signup successful'
      redirect_to '/'
    else
      puts user.errors.messages
      flash[:notice] = 'Please try again'
      redirect_to '/signup'
    end
  end

  def new
  end

  def index
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password)
  end
end
