class OrdersController < ApplicationController
  #before_filter :authenticate_user!
  def index
	current_user= User.find(1)
    @orders = current_user.orders.all( :limit => 10, :order => "id DESC" )
    
    
	checkBoxVal = session["user_check_box"]
	
    checkBoxVal.each do |i|
	  	graph = Koala::Facebook::GraphAPI.new(session["user_token"])
		image_path="https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xpa1/v/t1.0-1/c0.0.50.50/p50x50/10423943_655616364534852_6986801926670704871_n.jpg?oh=3cb50271dddaeccb7ed9adc647d43c14&oe=545D7B35&__gda__=1416174859_39a1b78ba96d67b5ce0f12b17a5ed398"
		message = 'Ruby is the most beautiful gem.'
		graph.put_picture( image_path, {message: message}, i)
	end
  end

  def create
  
	current_user= User.find(1)
    @order = current_user.orders.build
    @order.return_url = order_execute_url(":order_id")
    @order.cancel_url = order_cancel_url(":order_id")
    
    @order.amount=params[:order][:amount]
    @order.description=params[:order][:description]
    
    if params[:order][:payment_method] and @order.save
      if @order.approve_url
        redirect_to @order.approve_url
      else
        redirect_to orders_path, :notice => "Order[#{@order.description}] placed successfully"
      end
    else
      render :create, :alert  => @order.errors.to_a.join(", ")
    end
    
    #render json: params[:order]
    
  end

  def execute
    current_user= User.find(1)
    order = current_user.orders.find(params[:order_id])
    if order.execute(params["PayerID"])
      redirect_to orders_path, :notice => "Order[#{order.description}] placed successfully"
    else
      redirect_to orders_path, :alert => order.payment.error.inspect
    end
  end

  def cancel
    current_user= User.find(1)
    order = current_user.orders.find(params[:order_id])
    unless order.state == "approved"
      order.state = "cancelled"
      order.save
    end
    redirect_to orders_path, :alert => "Order[#{order.description}] cancelled"
  end

  def show
    current_user= User.find(1)
    @order = current_user.orders.find(params[:id])
  end
 
  
end
