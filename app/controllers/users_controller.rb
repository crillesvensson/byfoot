class UsersController < ApplicationController
  before_action :authenticate_user!
  def home
  	@user = current_user
  end



  def user_params
  	params.require(:user).permit(:email, :encrypted_password)
  end

end
