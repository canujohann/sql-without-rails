require_relative "RgRecords"

class User < RgRecords

	attr_accessor :id, :name, :detail

	#constructor
	def initialize()
		connection()
	end

	#ユーザー検索（IDで）
	def find(searchId)

		result = @my.query("SELECT id,name,detail from #{@table} where id=#{searchId}")  

		#一致する情報がなければnil
		return nil if result.length == 0

		id 		= result[0][0]
		name 	= result[0][1]
		details = result[0][2]

		return self

	end

end