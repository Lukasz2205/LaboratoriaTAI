class ApplicationController < ActionController::Base
  SECRET = "sekret"

  def not_found
    render json: { error: 'not found' } 
  end 

  def authentication
    # Pobranie danych z headera autoryzacji
    @decode_data = request.headers['Authorization']
    # Usuniecie spacji 
    @decode_data = decode_user_data(@decode_data.split(' ').last) if @decode_data
    user_data = @decode_data[0]['user_data'] unless !@decode_data
    @user = User.find_by(id: user_data)
    if @user 
      return true 
    else
      render json: { message: 'Invalid credentials' } 
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
