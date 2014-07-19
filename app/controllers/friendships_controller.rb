class FriendshipsController < ApplicationController
  def index
    friendships = current_user.friendships
    friendshipsRequested = Friendship.where( 'friend_id = ?', current_user.id )
    @friendRequests = []
    @friends = []
    friendships.each do | friendship |
      if friendship.accepted == true
        @friends << User.find(friendship.friend_id)
      end
    end

    friendshipsRequested.each do | friendship |
      if friendship.accepted == true
        @friends << User.find(friendship.user_id)
      elsif
        @friendRequests << friendship
      end
    end
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @friendship.accepted = false
    if @friendship.save
      redirect_to user_path(User.find(params[:friend_id]))
    else
      flash[:error] = "Unable to send friend request"
      redirect_to user_path(User.find(params[:friend_id]))
    end
  end

  def update
    @friendship = User.find(params[:user_id]).friendships.find(params[:id])
    if params[:accept] == 'true'
      @friendship.accepted = true
      @friendship.save
      flash[:notice] = "Friendship Accepted"
    else
      @friendship.destroy
      flash[:notice] = "Friendship declined"
    end
    redirect_to friendships_path
  end

  def destroy
    @friendship = current_user.friendships.find_by_id(params[:id])
    if @friendship.blank?
      @friendship = User.find(params[:friend_id]).friendships.find_by_id(params[:id])
    end
    if !@friendship.blank?
      @friendship.destroy
    end
    flash[:notice] = "Removed friendship."
    redirect_to friendships_path
  end
end