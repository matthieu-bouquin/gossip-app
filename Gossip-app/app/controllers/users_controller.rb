class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]
  

  def new 
  end 

  def create
     @user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    @user.city = City.all.sample

    if @user.save 
      log_in(@user) 
      remember(@user) if params[:remember_me]  
      flash[:success] = "Bienvenue, #{@user.first_name} !"
      redirect_to root_path
    else
      flash[:warning] = @user.errors.full_messages
      render :new 
    end
  end
  
  def show
    @user = User.find(params[:id]) 
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
