class ApiBaseController < ApplicationController
  SECRET = "sekret"

  def not_found
    render json: { error: 'not found' } 
  end 

  def authentication
    @decode_data = request.headers['Authorization']
    @decode_data = decode_user_data(@decode_data.split(' ').last) if @decode_data
    user_data = @decode_data[0]['user_data'] unless !@decode_data
    @user = User.find_by(id: user_data)
    if @user 
      return true 
    else
      render json: { message: 'Invalid credentials' } 
    end 
  end 
end 