class Team < ActiveRecord::Base
	belongs_to :grouping
	
	validates_associated :grouping
	validates_presence_of :grouping_id
end
