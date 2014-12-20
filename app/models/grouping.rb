class Grouping < ActiveRecord::Base
	belongs_to :grouping, foreign_key: "parent_id"
	
	#validates_associated :grouping
	validates_presence_of :parent_id
end
