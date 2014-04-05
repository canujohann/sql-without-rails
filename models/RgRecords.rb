require 'xmlsimple'
require 'mysql2'

class RgRecords

	def initialize()
		raise "抽象クラスなので、インスタンス化できません！"
	end

	def connection()

		# MySQL接続 
		#if @my == nil
			database = XmlSimple.xml_in("config/database.xml")
			@my  = Mysql2::Client.new(:host => database['hostname'][0].to_s, :username => database['username'][0].to_s, :password => database['password'][0].to_s, :database => database['dbname'][0].to_s)
		#end

		#テーブル名設定
		@table = self.class.to_s.downcase

	end

	#find by用
	def method_missing(method_id, *arguments)
	  if match = /find_(all_by|by)_([_a-zA-Z]\w*)/.match(method_id.to_s)
	    find(arguments[0])
	  else
	    super
	  end
	end

end