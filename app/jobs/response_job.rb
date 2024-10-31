class ResponseJob
  include Sidekiq::Job

  def perform(message, chatid)
    chat = Chat.find(chatid)
    ai_service = ExternalAiService.new
    ai_response = ai_service.get_response(message)
    if ai_response
      @response_message = chat.messages.create!(content: ai_response, message_type: :response)
      Turbo::StreamsChannel.broadcast_append_to(
        "message-list",
        target: "message-list",
        partial: "shared/message",
        locals: { message: @response_message }
      )
    else
      Rails.logger.warn "No AI response generated"
    end
  end
end



# class ResponseJob
#   include Sidekiq::Job

#   def perform(message, chatid)
#     chat = Chat.find(chatid)
#     ai_service = ExternalAiService.new
#     ai_response = ai_service.get_response(message)

#     if ai_response
#       @response_message = chat.messages.create!(content: ai_response, message_type: :response)
#       Turbo::StreamsChannel.broadcast_append_to(
#         "message-list",
#         target: "message-list",
#         partial: "shared/message",
#         locals: { message: @response_message }
#       )
#     end
#   end
# end
