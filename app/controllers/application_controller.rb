class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  helper_method :current_user
  before_filter :parse_facebook_cookies

	def current_user
		@current_user ||= session[:user_id] if session[:user_id]
	end
  
  
	def parse_facebook_cookies
		@facebook_cookies = Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
	end
  
  
end
