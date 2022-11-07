module Api
  class AuthenticationApiController < ApiBaseController
    SECRET = 'sekret'
    before_action :authentication, except: %i[login]

    def new 
    end 

    def login
      @user = User.find_by(login: params[:login])
      if @user&.authenticate(params[:password])
        payload = { user_data: @user.id, exp: 5.minutes.from_now.to_i }
        token = JWT.encode payload, SECRET, "HS256"
        render json: { token: token, user: @user, roles: @user.roles }, status: :ok
      else 
        render json: { error: 'Brak dostępu' }, status: :unauthorized
      end 
    end 

    private 
    
    def login_params 
      params.permit(:login, :password)
    end 
  end
end 