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

    @files = @current_user.files
            .joins(:blob).where('filename LIKE ?', "#{params[:hint]}%")
            .includes(:blob)
            .select("active_storage_attachments.*")

    case params[:sort]
    when 'created_at'
      @files = @files.order(params[:sort])
    when 'name'
      @files = @files.all.sort_by{|file| file.filename }
    when 'size'
      @files = @files.all.sort_by{|file| file.byte_size }
    end

    @shared_files = SharedFileAssociation.get_shared_files(@current_user.id)
    case params[:share_sort]
    when 'created_at'
      @shared_files = @shared_files.order(params[:share_sort])
    when 'name'
      @shared_files = @shared_files.all.sort_by{|file| file.filename }
    when 'size'
      @shared_files = @shared_files.all.sort_by{|file| file.byte_size }
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password)
  end
end