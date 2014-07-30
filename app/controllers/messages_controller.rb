class MessagesController < ApplicationController

	def index
		@messages = Message.where("receiver = ?", current_user.id).order('id DESC')
		@newMessages = Message.where("receiver = ? AND hasRead = ?",current_user.id, false)
		@oldMessages = Message.where("receiver = ? AND hasRead = ?",current_user.id, true)
	end

	def create
		@user = User.find(params[:user_id])
		@message = Message.new(message_params)
		@message.sender = current_user.id
		@message.receiver = @user.id
		@message.hasread = false
		if @message.save
			flash[:notice] = "Message sent"
			redirect_to user_path(@user)
		else
			render action: 'new'
		end
	end

	def new
		@user = User.find(params[:id])
		@message = Message.new
	end

	def edit
		
	end

	def show
		@user = User.find(params[:sender])
		@message = Message.find(params[:id])
		@message.hasread = true
		@message.save
	end

	def destroy
		@message = Message.find(params[:id])
		@message.destroy
		redirect_to messages_path
	end

	private 

  	def message_params
  		params.require(:message).permit(:title, :message, :sender, :receiver, :hasread)
  	end

end