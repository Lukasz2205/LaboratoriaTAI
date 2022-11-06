class SessionsController < ApplicationController 
  before_action :logged_in?
  def new 
  end 

  def create
    @user = User.find_by(login: params[:session][:login])
    if @user&.authenticate(params[:session][:password])
      session[:user_id] = @user.id 
      redirect_to books_path, notice: 'Pomyslnie zalogowano'
    else 
      render :new, alert: 'Podano bledne dane!'
    end  
  end 

  def destroy 
    session[:user_token] = nil
    redirect_to books_path, notice: 'Wylogowano'
  end 
end 