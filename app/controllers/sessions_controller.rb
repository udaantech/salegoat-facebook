class SessionsController < ApplicationController
 def create
    render :text => request.env['rack.auth'].inspect
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
