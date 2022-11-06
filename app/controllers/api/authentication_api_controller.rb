module Api
  class AuthenticationApiController < ApiBaseController
    protect_from_forgery with: :null_session

    def login
      @user = User.find_by(login: params[:login])
      if @user&.authenticate(params[:password])
        token = encode_user_data({ user_data: @user.id, exp: 5.minutes.from_now.to_i })
        if api_request?
          respond_to do |format|
            format.json  { render json: { token: token, user: @user, roles: @user.roles } }
          end
        else 
          respond_to do |format|
            session[:user_token] = token
            format.html  { redirect_to(root_path, notice: 'Pomyslnie zalogowano.') }
          end
        end 
      else
        if api_request?
          respond_to do |format|
            format.json  { render json: { message: "invalid credentials" } }
          end 
        else 
          respond_to do |format|
            format.html  { redirect_to(login_path, notice: 'Invalid credential') }
          end
        end 
      end
    end 

    private 

    def api_request?
      request.content_type == 'application/json'
    end
    
    def login_params 
      params.permit(:email, :password)
    end 
  end
end 