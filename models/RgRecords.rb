require 'xmlsimple'
require 'mysql2'
require 'yaml'

class RgRecords

	def initialize()
		raise "抽象クラスなので、インスタンス化できません！"
	end

	def connection()

		# MySQL接続 
		require_relative("connection.rb")
		@database, @my = Connection::connect

		#@database = YAML.load_file('config/database.yml')
		#@my  = Mysql2::Client.new(:host => @database['hostname'].to_s, :username => @database['username'].to_s, :password => @database['password'].to_s, :database => @database['dbname'].to_s)

		#テーブル名設定
		@table = self.class.to_s.downcase

	end

	#find by用
	def method_missing(method_id, *arguments)
	  if match = /find_by_([_a-zA-Z]\w*)/.match(method_id.to_s)
	   	columns 	=  get_columns
	   	column_name = method_id[8..method_id.length]
	   	return nil unless columns.include?(column_name)
	    find_by(column_name, arguments[0])
	  else
	    super
	  end
	end

	#テーブルのcolums名を取得
	def get_columns
		columns = @my.query("SHOW COLUMNS FROM #{@table} FROM #{@database['dbname'].to_s} ")
		columns_array = Array.new
		
		columns.each do |a,b|
			columns_array.push(a["Field"]) unless a == nil
		end

		return columns_array

	end

end