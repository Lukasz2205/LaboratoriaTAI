class AuthenticationApiController < ApplicationController
  protect_from_forgery with: :null_session

  def login
    @user = User.find_by(login: params[:login])

    if @user && @user.authenticate(params[:password])
      token = encode_user_data({ user_data: @user.id })
      render json: {token: token, user: @user, roles: @user.roles }
    else
      render json: { message: "invalid credentials" }
    end
  end 

  private 

  def login_params 
    params.permit(:email, :password)
  end 
end