require 'mysql2'
require 'singleton'
require 'yaml'

class Connection
    include singleton #singletonパターン
	def connect
		database = YAML.load_file('config/database.yml')
		my  = Mysql2::Client.new(connection_info)
		return database, my
	end
	#DB接続情報を取得
	def connection_info
		database = YAML.load_file('config/database.yml')
		{:host => 'database['hostname'].to_s', :username => database['username'].to_s, :password => database['password'].to_s, :database => database['dbname'].to_s
	end
end