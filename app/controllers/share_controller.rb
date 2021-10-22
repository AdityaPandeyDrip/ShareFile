class ShareController < ApplicationController
  before_action :authenticate_user
  def create
    email = params[:email]
    file = @current_user.files.find_by(id: params[:file]).blob if params[:file].present?
    user = User.find_by(email: email)
    if user.present? && file.present? && user != @current_user
      if user.shared_files.attach(file)
        flash[:notice] = 'File shared Successfully'
      else
        flash[:notice] = 'File sharing Unsuccessfull'
      end
    else
      flash[:notice] = 'EmailId Invalid'
    end
    redirect_to '/'
  end

  def new
    @file = params[:file]
  end

  def delete
    file = @current_user.shared_files.find_by(id: params[:file])
    if file.present?
      file.purge
      flash[:notice] = 'Shared File Deleted Successfully'
    else
      flash[:notice] = 'Shared File Deletion Unsuccessfull'
    end
    redirect_to '/'
  end
end
