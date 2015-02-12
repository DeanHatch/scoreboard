require 'digest/sha1'

class Customer < ActiveRecord::Base
	
	validates_presence_of :userid
	validates_uniqueness_of :userid
	
	attr_accessor :password_confirmation
	validates_presence_of :password
	#validates_presence_of :password_confirmation, if: :password.changed?
	validates_confirmation_of :password
	
	validate :password_non_blank
	
	def self.authenticate(userid, password)
		cust = self.find_by_userid(userid)
		if cust
			expected_password = encrypted_password(password, cust.salt)
			if cust.hashed_password != expected_password
				cust = nil
			end
		end
		cust
	end
	
	def password
		@password
	end
	
	def password=(pwd)
		@password = pwd
		#@password = 'DRH'
		return if pwd.blank?
		create_new_salt
		self.hashed_password = Customer.encrypted_password(self.password, self.salt)
	end
	
private
	
	def password_non_blank
		errors.add(:password, " is missing") if hashed_password.blank?
	end
	
	def create_new_salt
		self.salt = self.object_id.to_s + rand.to_s
	end
	
	
	def self.encrypted_password(password, salt)
		string_to_hash = password + "wibble" + salt
		Digest::SHA1.hexdigest(string_to_hash)
	end
	
	
end
