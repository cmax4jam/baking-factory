class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def check_login
    redirect_to login_url, alert: "You need to log in to view this page." if current_user.nil?
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access Denied."
    redirect_to home_path
  end

  # handle 404 errors with an exception as well
  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:error] = "Record Not Found"
    redirect_to home_path
  end

  def cart_size
    sum = 0
    return sum if session[:cart].empty? # skip if cart empty...
    session[:cart].each do |item_id, quantity|
      sum += quantity
    end
    sum
  end
  helper_method :cart_size

end
