class SessionsController < ApplicationController
def create
	 
	 auth = request.env["omniauth.auth"] 
     provider=auth.provider
     userId=auth.uid
     userName=auth.info.name
     userToken=auth['credentials']['token']
     session[:user_id] = userId
     #session[:user_token] = userToken
     session[:user_token] = 'CAACEdEose0cBAHt1jWkfr8KI03ZBkZBv2SrxNEZC7ZBJBABdEUvo0mif5ZASibn3fbL0LPGFmgfuZC81pEJOwScpIMNl3awVrbGr1oP1NAq3ZAYmtYK67Ok7es5XnWm4jIel4mLx85DzBsUrx2Lj63JDySwzcM4EQXeUSZCPl5vlEV0wfbIDkEudEj7trhgQvgPrOAxXrYm89JhpFN5ap0Gy8285nhr5K0EZD'
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
