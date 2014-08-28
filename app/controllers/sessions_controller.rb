class SessionsController < ApplicationController
def create
	 
	 auth = request.env["omniauth.auth"] 
	 
	 #render json: auth
	 
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
     session[:user_token] = 'CAACEdEose0cBAM9sE6zMqHk1WZAFg4KD1yGqWBLU0rl2USXxsXq6ogJOz9fFSrmAFWge1fiyOW06ZCDE3a6ks5A79ANA6ZAlxhk6pKw7E8pHYJN0udd9qZAp9oa8ZBHheQCEpbjzzpCBkVwIZBBZBpwFuEiTpxt3H5aHFrAWQd6tuYHZAJCQOnPQodSPv29GkatUuUZBd2RVPn3iP9JZBterRVXbe7ZAVx6Fd0ZD'
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
