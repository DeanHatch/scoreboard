class Grouping < ActiveRecord::Base
	belongs_to :grouping, foreign_key: "parent_id"
	
	#validates_associated :grouping
	validates_presence_of :parent_id
	
	# (Recursive) Return an Array with this Grouping appended to the end of the Array returned by
	# sending this method to the parent of this Grouping.
	def hierarchy()
		self.parent_id ? Grouping.find(self.parent_id).hierarchy << self.name  : [self.name]
	end
	
	# Return the Collection of Teams that identify this as their Grouping.
	def teams()
		Team.where(grouping: self)
	end
	
	# Return true iff there exists at least one Team that identifies this as its Grouping.
	def hasTeams?()
		self.teams.count>0
	end
	
end
