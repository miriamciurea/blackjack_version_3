# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Cleaning database..."

Group.destroy_all
User.destroy_all
Dare.destroy_all
Game.destroy_all
Member.destroy_all

puts "Database cleaned!"

puts "Creating some users..."

User.create(email: "miriam@email.com", nickname: "miriam", score: "0", password: "123456")
User.create(email: "serban@email.com", nickname: "serban", score: "0", password: "123456")
User.create(email: "ecem@email.com", nickname: "ecem", score: "0", password: "123456")
User.create(email: "alex@email.com", nickname: "alex", score: "0", password: "123456")

puts "Users created!"

puts "Creating groups..."

Group.create(user_id: User.find_by(nickname: "miriam").id, name: "Miriam's group", max_members: 3)
Group.create(user_id: User.find_by(nickname: "serban").id, name: "The best group", max_members: 4)
Group.create(user_id: User.find_by(nickname: "ecem").id, name: "Friends", max_members: 5)

puts "Groups created!"

puts "Putting members in groups..."

Member.create(user_id: User.find_by(nickname: "alex").id, group_id: Group.find_by(name: "Miriam's group").id)
Member.create(user_id: User.find_by(nickname: "serban").id, group_id: Group.find_by(name: "Miriam's group").id)
Member.create(user_id: User.find_by(nickname: "alex").id, group_id: Group.find_by(name: "Friends").id)
Member.create(user_id: User.find_by(nickname: "miriam").id, group_id: Group.find_by(name: "Friends").id)

puts "You have to have some dares also..don't forget"

puts "Seed is seeded!"
