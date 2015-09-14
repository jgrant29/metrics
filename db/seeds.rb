require 'faker'

# Create Users
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email, 
    password: Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save
end
users = User.all

# Create RegisteredApplication
10.times do
  RegisteredApplication.create!(
    name:   Faker::Lorem.sentence,
    url:    Faker::Internet.url,
    )
end
registered_applications = RegisteredApplication.all

# Create RegisteredApplication
50.times do
  Event.create!(
    registered_application: registered_applications.sample,
    name: Faker::Lorem.sentence
    )
end

events = Event.all

admin = User.new(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)
admin.skip_confirmation!
admin.save!

# Create a moderator
moderator = User.new(
  name:     'Moderator User',
  email:    'moderator@example.com',
  password: 'helloworld',
  role:     'moderator'
)
moderator.skip_confirmation!
moderator.save!

# Create a member 
guest = User.new(
  name:     'Guest User', 
  email:    'member@example.com',
  password: 'helloworld'
)
guest.skip_confirmation!
guest.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} registered applications created"
puts "#{Event.count} events created"
