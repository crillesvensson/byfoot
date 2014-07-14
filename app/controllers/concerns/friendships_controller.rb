class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friendships
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @userFriendship = User.find(params[:friend_id]).friendships.build(friend_id: current_user.id)
    if @friendship.save
      if @userFriendship.save
        flash[:notice] = "Added friend."
        redirect_to friendships_path
      else
        @friendship.destroy
        flash[:error] = "Unable to add friend."
        redirect_to user_path(User.find(params[:friend_id]))
      end
    else
      flash[:error] = "Unable to add friend."
      redirect_to user_path(User.find(params[:friend_id]))
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @userFriendShip = User.find(@friendship.friend_id).friendships.find_by( friend_id: current_user.id  )
    @friendship.destroy
    @userFriendShip.destroy
    flash[:notice] = "Removed friendship."
    redirect_to friendships_path
  end
end