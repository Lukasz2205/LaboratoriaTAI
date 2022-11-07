class ApiBaseController < ApplicationController
  SECRET = "sekret"

  def not_found
    render json: { error: 'not found' } 
  end 

  def authentication
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JWT.decode header, SECRET, true, { algorithm: "HS256" }
      @current_user = User.find(@decoded[0]['user_data'])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end 
end 