
require 'xmlsimple'
require 'mysql2'
require 'singleton'
require 'yaml'

class Connection

    include Singleton
	
	def connect

		database = YAML.load_file('config/database.yml')
		my  = Mysql2::Client.new(:host => database['hostname'].to_s, :username => database['username'].to_s, :password => database['password'].to_s, :database => database['dbname'].to_s)
		
		return database, my
	end
end