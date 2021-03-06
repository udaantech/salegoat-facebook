class OrdersController < ApplicationController
  def index
  
   if session["user_id"]
		current_user= User.find(session["user_tbl_id"])
		@orders = current_user.orders.all( :limit => 100, :order => "id DESC" )
		
		@latestOrder = current_user.orders.last
			if(@latestOrder.state=="approved" || @latestOrder.state=="free")
				checkBoxVal = session["user_check_box"]
				graph = Koala::Facebook::GraphAPI.new(session["user_token"])
				checkBoxVal.each do |i|
					
					image_path="#{request.protocol}#{request.host_with_port}/#{session[:user_tbl_id]}_facebook_post.png"
					#image_path="http://facebookeasylister.com/5_facebook_post.png"
					message = "#{session[:links]}
				   			   #{session[:productName]}
				 			   #{session[:productDesc]}"

					if(session[:uploadFile]!='')		
					graph.put_picture( image_path, {message: message}, i)
					else
					graph.put_object(i, "feed", message: message)	
					end	
				end
			end
	else
		#redirect_to root_path
	end
	
  end

  def create
  
  if session["user_id"]
  		graph = Koala::Facebook::GraphAPI.new(session["user_token"])
  		fbUser = graph.get_objects('me')
  		fbUserId = fbUser['me']['email'] #10152639308085731 
  			
		current_user= User.find(session["user_tbl_id"])
		@order = current_user.orders.build
		@order.return_url = order_execute_url(":order_id")
		@order.cancel_url = order_cancel_url(":order_id")
		
		@order.amount=params[:order][:amount]
		#@order.description=params[:order][:description]
		@order.description=session[:productName]
		if params[:order][:payment_method] and @order.save
		  if @order.approve_url and fbUserId == 'waderandall@mac.com' #wade id
		  	@order.state = 'free'
		  	@order.save
		  	redirect_to orders_path, :notice => "Order[#{@order.description}] placed successfully"	
		  else
			redirect_to @order.approve_url
		  end
		else
		  render :create, :alert  => @order.errors.to_a.join(", ")
		end
    
    else
		redirect_to root_path
    end
    
  end

  def execute
    current_user= User.find(session["user_tbl_id"])
    order = current_user.orders.find(params[:order_id])
    if order.execute(params["PayerID"])
      redirect_to orders_path, :notice => "Order[#{order.description}] placed successfully"
    else
      redirect_to orders_path, :alert => order.payment.error.inspect
    end
  end

  def cancel
    current_user= User.find(session["user_tbl_id"])
    order = current_user.orders.find(params[:order_id])
    unless order.state == "approved"
      order.state = "cancelled"
      order.save
    end
    redirect_to orders_path, :alert => "Order[#{order.description}] cancelled"
  end

  def show
    current_user= User.find(session["user_tbl_id"])
    @order = current_user.orders.find(params[:id])
  end
 
  
end
