class SessionsController < ApplicationController
def create
	 
	 auth = request.env["omniauth.auth"] 
     provider=auth.provider
     userId=auth.uid
     userName=auth.info.name
     userToken=auth['credentials']['token']
     useremail=auth.info.email
     
     @userFound=User.where(email: useremail)
     
	if @userFound.present?
	
		@userFound.each do |user| 
			 session[:user_tbl_id] = user.id
		end
     
    
    else
			User.new(:email => useremail, :created_at => Date.today.to_s, :credit_card_id => 'CARD-1V3373973L607891KKP6JBJA', :credit_card_description => 'xxxxxxxxxxxx1111 Expire on 5/2050').save
			@userAlready=User.where(email: useremail)
			@userAlready.each do |user|  
			 session[:user_tbl_id] = user.id
			end
    end
     
     
     session[:user_id] = userId
     #session[:user_token] = userToken
     session[:user_token] = 'CAACEdEose0cBAJGIHmGZBDYBUKZCINkTp0HWmhCB4Kw3ePZA5dyZAuEuLwo0B1jZBg2mMYGLUmZBeBO5HzLavOabEduQlHtKhLeXZB20Kph1jAMlg0X2wUqbIEAAt74hVJ6zTVJqZBJ2Rq8Lt3xZC52ZBMxpDf4CQ8ykEEB6yhXtCEHYdrYJBDRoZC8dXZAdnhIgFhGFzJutgVpJQUDLevtFo6U6'
     session[:user_name] = userName
     redirect_to url_for(:controller => "home", :action => "dashboard")
     
  end

  def destroy
    session[:user_id] = nil
    session[:user_token] = nil
    session[:user_name] = nil
    session[:user_tbl_id] = nil
    session[:user_check_box]=nil
    session[:productName]=nil
    session[:productDesc]=nil
    session[:links]=nil
    session[:linkTitle]=nil
    redirect_to root_path
  end
end
