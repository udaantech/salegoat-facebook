class HomeController < ApplicationController
 

 
  def show
  end
  
  def dashboard
  		
  	@order = Order.new

	  if session["user_id"]
		graph = Koala::Facebook::GraphAPI.new(session["user_token"])
		@likes = graph.get_connections("me", "groups")
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
	
   end
   
    def putCheckBox
	 session[:user_check_box] = params[:type]
	 session[:productName] = params[:productName]
	 session[:productDesc] = params[:productDesc]
	 session[:links] = params[:links]
	 session[:linkTitle] = params[:linkTitle]
	 render text: session["user_check_box"]
   end
   
 	def putImage
 		img = "#{params[:current_user]}_facebook_post.png"
 		File.open("public/#{img}", 'wb') do|f|
		f.write(Base64.decode64(params[:data]))
		end
		render text: "#{request.protocol}#{request.host_with_port}/#{img}"
 	end  
  
  def facebookGroup
	
  	render text: "#{request.protocol}#{request.host_with_port}/#{session[:user_tbl_id]}_facebook_post.png"
	checkBoxVal = session["user_check_box"]
	graph = Koala::Facebook::GraphAPI.new(session["user_token"])
	checkBoxVal.each do |i|
		image_path="http://mintywhite.com/wp-content/uploads/2012/10/fond-ecran-wallpaper-image-arriere-plan-hd-29-HD.jpg"
		message = "#{session[:links]}
				  #{session[:productName]}
				  #{session[:productDesc]}"

		graph.put_picture( image_path, {message: message}, i)
	
	end
	render text: session["user_check_box"]
	
	
  end
  
  def privacy
  
  end

   def myorder
  
   if session["user_id"]
		current_user= User.find(session["user_tbl_id"])
		@orders = current_user.orders.all( :limit => 100, :order => "id DESC" )

	else
		#redirect_to root_path
	end
	
  end
  
  
end