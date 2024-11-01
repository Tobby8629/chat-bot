class Message < ApplicationRecord
  belongs_to :chat
  validates :content, presence: true
  enum message_type: [ :question, :response ]
end
