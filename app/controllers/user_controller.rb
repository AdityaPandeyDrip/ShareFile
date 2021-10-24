class UserController < ApplicationController
  def create
    if User.find_by(email: params[:user][:email]).present?
      flash[:notice] = 'Account with this email already exist'
      return redirect_to '/signup'
    end
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
    return redirect_to '/login' unless current_user

    if params[:sort] == 'created_at'
      @files = @current_user.files.order(params[:sort])
    elsif params[:sort] == 'name'
      @files = @current_user.files.all.sort_by{|file| file.filename }
    elsif params[:sort] == 'size'
      @files = @current_user.files.all.sort_by{|file| file.byte_size }
    else
      @files = @current_user.files
    end

    if params[:share_sort] == 'created_at'
      @shared_files = @current_user.shared_files.order(params[:share_sort])
    elsif params[:share_sort] == 'name'
      @shared_files = @current_user.shared_files.all.sort_by{|file| file.filename }
    elsif params[:share_sort] == 'size'
      @shared_files = @current_user.shared_files.all.sort_by{|file| file.byte_size }
    else
      @shared_files = @current_user.shared_files
    end

    @files = @files.blobs.where('filename LIKE ?', "#{params[:hint]}%")
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password)
  end
end
