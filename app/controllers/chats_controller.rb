class ChatsController < ApplicationController
	def index
    	@chats = Chat.all
  	end

  	def create
    	@chat = Chat.create!(chat_params)
  	end

  	private

  	def chat_params
  	params.require(:chat).permit(:message)
  end
end