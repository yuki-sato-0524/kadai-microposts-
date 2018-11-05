class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  
  private
  
  include SessionsHelper
  
  def require_user_logged_in
    redirect_to login_url unless logged_in?
  end
  
  def count(user)
    @count_microposts = user.microposts.count
  end
  
  
end
