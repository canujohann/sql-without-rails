require_relative "models/user.rb"

#find method
user = User.new.find(1)

#find_by_xx method
user2 = User.new.find_by_id(2)

user3 = User.new.find_by_name("johann")

#ユーザー情報を表示
puts "my user name : #{user.name}"
puts "my user name details : #{user.detail}"

puts "my second user name : #{user2.name}"
puts "my second user name details : #{user2.detail}"

puts "my third user name : #{user3.name}"
puts "my thrid user name details : #{user3.detail}"