class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
  	@users = User.all
  end

  def show
  	@user = current_user
  end

  def edit
  	@user = current_user
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      redirect_to user
    else
      render 'edit'
    end
  end

  def user_params
  	params.require(:user).permit(:firstname, :lastname, :phone ,:information, :birthday, :country, :city)
  end

end
