require 'xmlsimple'
require 'mysql2'

class RgRecords

	def initialize()
		raise "抽象クラスなので、インスタンス化できません！"
	end

	def connection()

		# MySQL接続 
		@database = XmlSimple.xml_in("config/database.xml")
		@my  = Mysql2::Client.new(:host => @database['hostname'][0].to_s, :username => @database['username'][0].to_s, :password => @database['password'][0].to_s, :database => @database['dbname'][0].to_s)

		#テーブル名設定
		@table = self.class.to_s.downcase

	end

	#find by用
	def method_missing(method_id, *arguments)
	  if match = /find_by_([_a-zA-Z]\w*)/.match(method_id.to_s)

	   	columns 	=  get_columns
	   	column_name = method_id[8..method_id.length]
	   	
	   	return nil unless columns.include?(column_name)

	    find(arguments[0])
	  else
	    super
	  end
	end

	#テーブルのcolums名を取得
	def get_columns
		columns = @my.query("SHOW COLUMNS FROM #{@table} FROM #{@database['dbname'][0].to_s} ")
		columns_array = Array.new
		
		columns.each do |a,b|
			columns_array.push(a["Field"]) unless a == nil
		end

		return columns_array

	end

end