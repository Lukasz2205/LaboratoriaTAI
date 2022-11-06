class ApplicationController < ActionController::Base
  SECRET = "sekret"

  helper_method :current_user, :logged_in?

  def current_user
    current_user ||= User.find(decode_user_data(session[:user_token])[0]['user_data']) if session[:user_token]
  end

  def logged_in?
    !!current_user 
  end

  def require_user
    if !logged_in?
      redirect_to login_path, notice: "Musisz być zalogowany aby wykonać tą akcje" 
    end 
  end

  def encode_user_data(payload)
    token = JWT.encode payload, SECRET, "HS256"
    return token
  end

  def decode_user_data(token)
    begin
      data = JWT.decode token, SECRET, true, { algorithm: "HS256" }
      return data
    rescue => e
      puts e
    end
  end
end
