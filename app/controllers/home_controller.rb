class HomeController < ApplicationController
 

 
  def show
  end
  
  def dashboard
  
	  if session["user_id"]
		graph = Koala::Facebook::GraphAPI.new(session["user_token"])
		@likes = graph.get_connections("me", "groups")
		#render json: session["user_token"]
		
		
	   else
		redirect_to root_path
	   end
	
  
  end
  
   def create
   
   checkBoxVal=session["user_check_box"]
   
   checkBoxVal.each do |i|
	  	graph = Koala::Facebook::GraphAPI.new(session["user_token"])
		image_path="https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xpa1/v/t1.0-1/c0.0.50.50/p50x50/10423943_655616364534852_6986801926670704871_n.jpg?oh=3cb50271dddaeccb7ed9adc647d43c14&oe=545D7B35&__gda__=1416174859_39a1b78ba96d67b5ce0f12b17a5ed398"
		message = 'Ruby is the most beautiful gem.'
		graph.put_picture( image_path, {message: message}, i)
	end
   
	render text: checkBoxVal
	
   end
   
    def putCheckBox
	 session[:user_check_box] = params[:type]
	 session[:productName] = params[:productName]
	 session[:productDesc] = params[:productDesc]
	 session[:links] = params[:links]
	 render text: session["user_check_box"]
   end
   
   
  
  def facebookGroup
	graph = Koala::Facebook::GraphAPI.new(session["user_token"])
	image_path="https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xpa1/v/t1.0-1/c0.0.50.50/p50x50/10423943_655616364534852_6986801926670704871_n.jpg?oh=3cb50271dddaeccb7ed9adc647d43c14&oe=545D7B35&__gda__=1416174859_39a1b78ba96d67b5ce0f12b17a5ed398"
	message = 'Ruby is the most beautiful gem.'
	graph.put_picture( image_path, {message: message}, '405238599606802')
	
	#@likes = graph.get_connections("me", "groups")
	#graph.put_object('405238599606802', "feed", :message => "I am writing on a group wall!")
	
	
	
	render json: "sucess"
  end
  
  def privacy
  
  end
  
  
end
