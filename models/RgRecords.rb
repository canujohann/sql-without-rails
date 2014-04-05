require 'xmlsimple'
require 'mysql2'
require 'yaml'

# モデルの親クラス
class RgRecords

	def initialize()
		raise "抽象クラスなので、インスタンス化できません！"
	end

	def connection()

		# MySQL接続  singletonパターン
		require_relative("connection.rb")
		@database, @my = Connection.instance.connect

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

	#find by 検索
	def find_by(search_column, val)

		result = @my.query("SELECT id,name,detail from #{@table} where #{search_column}='#{val}'")  

		#一致する情報がなければnil
		return nil if result.size == 0

		@id 	= result.first["id"]
		@name 	= result.first["name"]
		@detail = result.first["detail"]

		return self

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