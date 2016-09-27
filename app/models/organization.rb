class Organization < ActiveRecord::Base
	
	has_many :competitions
	belongs_to :customer
	
	validates_uniqueness_of :name,
		message: "has been taken." 
	validates_presence_of :name,
		message: "has to have a name." 
	
end
