class SessionsController < ApplicationController

  def new
  end

  def create
    user = login(params[:username].downcase, params[:password],  params[:remember_me])
    if user
      flash[:notice] = "Thanks for signing in!"
      redirect_back_or_to root_path
    else
      flash[:error] = "Username or password was invalid."
      redirect_to login_path
    end
  end

  def destroy
    logout
    redirect_to root_url, :success => "You logged out! Come back soon :-)"
  end

end