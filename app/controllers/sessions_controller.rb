class SessionsController < ApplicationController 
  def new 
  end 

  def create
    user = User.find_by(login: params[:session][:login])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id 
      redirect_to root_path, notice: 'Pomyslnie zalogowano'
    else 
      render new, alert: 'Podano bledne dane!'
    end  
  end 

  def destroy 
    session[:user_id]
    redirect_to root_path, notice: 'Wylogowano'
  end 
end 