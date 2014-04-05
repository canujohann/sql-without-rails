require_relative "RgRecords"

class User < RgRecords

	attr_accessor :id, :name, :detail

	#constructor
	def initialize()
		connection()
	end

	#ユーザー検索（IDで）
	#TODO RgRecordsクラスに入れる！
	def find(searchId)

		result = @my.query("SELECT id,name,detail from #{@table} where id=#{searchId}")  

		#一致する情報がなければnil
		return nil if result.size == 0

		#TODO 自動的にマップさせた方がいい　↓↓↓
		@id 	= result.first["id"]
		@name 	= result.first["name"]
		@detail = result.first["detail"]

		return self

	end

end