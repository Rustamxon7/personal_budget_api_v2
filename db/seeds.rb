puts "🌱🌱🌱 Seeding... 🌱🌱🌱"

first_user = User.create!(
  email: "bob@gmail.com",
  username: "bob",
  password: "123456",
  password_confirmation: "123456",
  confirmed_at: Time.now
)

5.times do |i|
  Member.create!(
    username: Faker::Internet.username,
    user: first_user
  )
end

20.times do |i|
  Category.create!(
    name: Faker::Internet.username,
    kind: "income",
    members_ids: [1],
    user: first_user,
  )
end


8.times do |i|
  Transaction.create!(
    name: Faker::Internet.username,
    group: "income",
    category_id: 1,
    member_id: 1,
    amount: rand(1000..10000)
  )
end

puts "🌱🌱🌱 Seeding complete! 🌱🌱🌱"