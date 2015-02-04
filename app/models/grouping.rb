#  This class defines collections of Teams for the purpose of Standings and/or
#  Playoffs, as well as limiting or organizing the display of Results and Standings.
class Grouping < ActiveRecord::Base
	
	belongs_to :grouping, foreign_key: "parent_id"
	
	has_many :bracketcontests, foreign_key: "bracket_grouping_id"
	
	#validates_associated :grouping
	validates_presence_of :parent_id
	
	def self.default_comp(comp_id)
		self.default_scope { (where(competition_id: comp_id) ) }
	end
  

	# (Recursive) Return an Array with this Grouping appended to the end of the Array returned by
	# sending this method to the parent of this Grouping.
	def hierarchy()
		self.parent_id ? Grouping.find(self.parent_id).hierarchy << self.name  : [self.name]
	end

	# Concatenated names from very top down to this Grouping.
	def fullname()
		self.hierarchy.join(' ')
	end
	
	# Return the Collection of Groupings that identify this as their Parent.
	def subgroupings()
		Grouping.where(parent_id: self)
	end
	
	# Return true iff there exists at least one Grouping that identifies this as its Parent.
	def has_subgroupings?()
		self.subgroupings.count>0
	end
	
	# Return the Collection of Teams that identify this as their Grouping.
	def teams()
		Team.where(grouping: self)
	end
	
	# Return true iff there exists at least one Team that identifies this as its Grouping.
	def has_teams?()
		self.teams.count>0
	end
	
	# Groupings directly within this Grouping plus Groupings within any descendants of
	# this Grouping.
	def all_subgroupings()
		(self.subgroupings << self.subgroupings.collect{|sg| sg.all_subgroupings()}).flatten
	end
	
	# Teams directly within this Grouping plus Teams within any descendants of
	# this Grouping. Ordinarily there will be one or the other but not both. This
	# will handle the case where there is one or the other or both.
	def all_teams()
		(self.teams << self.subgroupings.collect{|sg| sg.all_teams()}).flatten
	end
	
end
