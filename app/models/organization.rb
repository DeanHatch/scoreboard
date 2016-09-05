class Organization < ActiveRecord::Base
	
	has_many :competitions
	
	validates_uniqueness_of :name,
		message: "has been taken." 
	validates_presence_of :name,
		message: "has to have a name." 
	
	
end
