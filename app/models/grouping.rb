class Grouping < ActiveRecord::Base
	belongs_to :grouping, foreign_key: "parent_id"
	
	#validates_associated :grouping
	validates_presence_of :parent_id
	
	def hierarchy()
		self.parent_id ? Grouping.find(self.parent_id).hierarchy << self.name  : [self.name]
	end
	
end
