class User < ApplicationRecord 
  has_many :user_roles
  has_many :roles, through: :user_roles

  has_secure_password


  def is_admin?
    empty = []
    roles.each { |s|  empty << s.name }
    return empty.include?('Administrator')
  end 

  def is_user?
    empty = []
    roles.each { |s|  empty << s.name }
    return empty.include?('user')
  end 
end 