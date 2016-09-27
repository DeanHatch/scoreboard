class Customer < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
	 :confirmable, :lockable, :timeoutable and :omniauthable
	 
  has_many :credits, inverse_of: :customer
  has_one :organization, inverse_of: :customer
  
end
