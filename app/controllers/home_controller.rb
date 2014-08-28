class HomeController < ApplicationController
 

 
  def show
  end
  
  def dashboard
  render json: "hello"
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
	 session[:linkTitle] = params[:linkTitle]
	 render text: session["user_check_box"]
   end
   
   
  
  def facebookGroup
	checkBoxVal = session["user_check_box"]
	graph = Koala::Facebook::GraphAPI.new(session["user_token"])
	checkBoxVal.each do |i|
		image_path="http://britishfamily.co.uk/wp-content/uploads/2013/02/toys.jpg"
		message = 'Hello it is just testing'
		graph.put_picture( image_path, {message: message}, i)
	
	end
	render json: session["user_check_box"]
	
	
  end
  
  def privacy
  
  end
  
  
end
