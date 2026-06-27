# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"

User.destroy_all

alice = User.create!(name: "Alice Kumar",email: "alice@zapro.com",role: :requester)
bob = User.create!(name: "Bob Singh",email: "bob@zapro.com",role: :approver)
carol = User.create!(name: "Carol Patel",email: "carol@zapro.com",role: :admin)

10.times do
  alice.purchase_requests.create!(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence,
    amount: Faker::Commerce.price(range: 100..10_000)
  )
end
puts "Seeded #{User.count} users, #{PurchaseRequest.count} purchase requests"