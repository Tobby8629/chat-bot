# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# User.destroy_all

# puts ("#{User.count}")


users = User.create!([
  { username: 'Alice', email: 'alice@example.com', password: 'password' },
  { username: 'Bob', email: 'bob@example.com', password: 'password' }
])


chats = Chat.create!([
  { user: users.first, title: 'Chat with AI on Science' },
  { user: users.last, title: 'General Questions' }
])


chats.each do |chat|
  chat.messages.create!(content: "What is the theory of relativity?", message_type: :question)
  chat.messages.create!(content: "The theory of relativity was developed by Einstein.", message_type: :response)
  chat.messages.create!(content: "What is the capital of France?", message_type: :question)
  chat.messages.create!(content: "The capital of France is Paris.", message_type: :response)
end

puts "Seeded #{User.count} users, #{Chat.count} chats, and #{Message.count} messages."
