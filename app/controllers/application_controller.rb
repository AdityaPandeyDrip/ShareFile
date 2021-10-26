class ApplicationController < ActionController::Base
  helper_method :current_user, :get_url, :file_size_verbose, :get_shared_url

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    redirect_to '/login' unless current_user
  end

  def get_shared_url(user_id, file_id)
    shared_file = User.find(user_id).files.find(file_id)
    get_url(shared_file) if shared_file.present?
  end

  def get_url(blob)
    Rails.application.routes.url_helpers.rails_blob_path(blob, only_path: true)
  end

  def file_size_verbose(byte)
    @kb = byte / 1024
    if @kb < 1024
        return "#{@kb} KB"
    end
    @mb = @kb / 1024
    if @mb < 1024
        return "#{@mb} MB"
    end
    @gb = @mb / 1024
    return "#{@gb} GB"
end
end
