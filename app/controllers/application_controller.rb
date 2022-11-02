class ApplicationController < ActionController::Base
  SECRET = "sekret"

  def not_found
    render json: { error: 'not found' } 
  end 

  def authentication 
    decode_data = decode_user_data(request.headers['token'])
    user_data = decode_data[0]['user_data'] unless !decode_data
    user = User.find(user_data)

    if user 
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
