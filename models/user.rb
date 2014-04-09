require_relative "RgRecords"
class User < RgRecords
	attr_accessor :id, :name, :detail
	def initialize ; connection() ; end
end