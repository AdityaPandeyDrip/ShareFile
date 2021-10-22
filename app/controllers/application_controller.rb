class ApplicationController < ActionController::Base
  helper_method :current_user, :get_url

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    redirect_to '/login' unless current_user
  end

  def get_url(blob)
    Rails.application.routes.url_helpers.rails_blob_path(blob, only_path: true)
  end
end
