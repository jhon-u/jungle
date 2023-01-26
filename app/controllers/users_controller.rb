class UsersController < ApplicationController
  
  def new; end

  def create
    input = user_params
    p input[:email]
    input[:email].split.first.downcase! unless input[:email].empty?
    user = User.new(input)

    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
