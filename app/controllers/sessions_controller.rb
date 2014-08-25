class SessionsController < ApplicationController
def create
	 
	 auth = request.env["omniauth.auth"] 
     provider=auth.provider
     userId=auth.uid
     userName=auth.info.name
     userToken=auth['credentials']['token']
     session[:user_id] = userId
     session[:user_token] = userToken
     session[:user_name] = userName
     redirect_to url_for(:controller => "home", :action => "dashboard")
  end

  def destroy
    session[:user_id] = nil
    session[:user_token] = nil
    session[:user_name] = nil
    redirect_to root_path
  end
end
