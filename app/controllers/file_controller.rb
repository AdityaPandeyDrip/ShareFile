class FileController < ApplicationController
  before_action :authenticate_user

  def attach
    file = params[:user][:file]
    if file.size < 10.megabytes
      if @current_user.files.attach(file)
        flash[:notice] = 'File uploaded Successfully'
      else
        flash[:notice] = 'File uploading Unsuccessfull'
      end
    else
      flash[:notice] = 'File size should be less than 1 Megabyte'
    end
    redirect_to '/'
  end

  def delete
    file = @current_user.files.find_by(id: params[:file])
    if file.present?
      file.purge
      flash[:notice] = 'File Deleted Successfully'
    else
      flash[:notice] = 'File Deletion Unsuccessfull'
    end
    redirect_to '/'
  end
end
