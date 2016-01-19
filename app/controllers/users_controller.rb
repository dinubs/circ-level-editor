class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_slug(params[:id])
  end

  def new
  end

  def create
    @user = User.new(new_permitted_params)

    if @user.save
      auto_login(@user)
      flash[:notice] = "Welcome to Circ Level Editor, try making a new level!"
      redirect_to root_path
    else
      flash[:error] = "Something is wrong with the information you provided"
      redirect_to signup_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

private
  def new_permitted_params
    params.require(:user).permit(:username, :password)
  end
end
