require 'mysql2'
require 'yaml'

# モデルの親クラス
class RgRecords

	def initialize
		raise "抽象クラスなので、インスタンス化できません！"
	end

	def connection
		# MySQL接続  singletonパターン
		require_relative("connection.rb")
		@database, @my = Connection.instance.connect
		#テーブル名設定
		@table = self.class.to_s.downcase
	end

	#find検索
	def find(search_id)
		result = @my.query("SELECT * from #{@table} where id=#{search_id}")
		#一致する情報がなければnil
		raise ArgumentError, "ユーザーIDが正しくありません" if result.size == 0
		#インスタンスのattributeをセット
		set_object_attributes(result.first)
		return self
	end

	#find by用
	def method_missing(method_id, *arguments)
	  if match = /find_by_([_a-zA-Z]\w*)/.match(method_id.to_s)
	   	columns =  get_columns
	   	column_name = method_id[8..method_id.length]
	   	raise ArgumentError, "find_byの引数が間違っています！" unless columns.include?(column_name)
	    find_by(column_name, arguments[0])
	  else
	    super
	  end
	end

	#find by 検索
	def find_by(search_column, val)
		result = @my.query("SELECT id,name,detail from #{@table} where #{search_column}='#{val}'")
		#インスタンスのattributeをセット
		set_object_attributes(result.first)
		return self
	end

	private

	#テーブルのcolums名を取得
	def get_columns
		columns = @my.query("SHOW COLUMNS FROM #{@table} FROM #{@database['dbname'].to_s} ")
		columns_array = Array.new
		columns.each do |a,b|
			columns_array.push(a["Field"]) unless a == nil
		end
		return columns_array
	end

	#SQL情報を抽出し、attributeに代入
	def set_object_attributes (result)
		get_columns.each do |column|
			if result.include?(column)
				instance_variable_set("@#{column}", result[column])
			end
		end
	end

end