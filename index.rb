require_relative "models/user.rb"

user = User.new.find(1)

puts user

puts "my user name is #{user.name}"

