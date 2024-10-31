class ChatController < ApplicationController
  before_action :authenticate_user!, only: [:show, :delete_chat]
  
  def show
    @findChat = Chat.find(params[:id])
    @messages = @findChat.messages
  end

  def send_message
    @new_chat = current_user.chats.create!(title: params[:message][0,15])   
    @message = @new_chat.messages.create!(content: params[:message], message_type: :question)
    ResponseJob.perform_async(@message.content, @new_chat.id)
    redirect_to chat_path(@new_chat)
  end

  def send_message_to_chat
    chat = current_user.chats.find(params[:id])
    @message = chat.messages.create!(content: params[:message], message_type: :question)
    @sentmessage = params[:message]
    
    ResponseJob.perform_async(@sentmessage, chat.id)
    
    respond_to do |format|
      format.turbo_stream
    end
  end
  


  def delete_chat
   @chat = current_user.chats.find(params[:id])
   puts @chat
    if @chat.destroy
      respond_to do |format|
        format.turbo_stream{ 
          render turbo_stream: turbo_stream.remove("chat#{@chat.id}")
         }
      end
    else
      # Log errors if the save fails
      Rails.logger.debug @chat.errors.full_messages.join(", ")
      # Optionally render errors or a response to handle the failure
    end
  end
end
