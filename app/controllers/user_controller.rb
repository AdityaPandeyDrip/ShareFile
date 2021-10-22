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
    @files = @current_user.files if current_user
    @shared_files = @current_user.shared_files if current_user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password)
  end
end
