require 'xmlsimple'
require 'mysql2'

class RgRecords

	def initialize()
		raise "抽象クラスなので、インスタンス化できません！"
	end

	def connection()
		database = XmlSimple.xml_in("config/database.xml")

		# MySQL接続 
		#@my =  Mysql.new(database['hostname'][0].to_s, database['username'][0].to_s, database['password'][0].to_s, database['dbname'][0].to_s)  
		@my  = Mysql2::Client.new(:host => database['hostname'][0].to_s, :username => database['username'][0].to_s, :password => database['password'][0].to_s, :database => database['dbname'][0].to_s)

		#テーブル名設定
		@table = self.class.to_s.downcase

	end

end