class SessionsController < ApplicationController

  def new 
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      log_in(user)
      remember(user) if params[:remember_me]
      redirect_to root_path
      flash[:success] = "Bienvenue, #{user.first_name} !"
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy 
    log_out(current_user)
    redirect_to root_path
  end
  
end
