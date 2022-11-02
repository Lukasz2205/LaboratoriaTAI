class UsersApiController < ApplicationController
  before_action :set_user, only: %i[show]  

  def index 
    @users = User.all

    render json: @users, include: :roles
  end 

  def show 
    render json: @user, include: :roles
  end 

  private 

  def set_user 
    @user = User.find(params[:id])
  end 
end  