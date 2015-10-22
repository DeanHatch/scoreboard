class AlertRequest < ActiveRecord::Base
  belongs_to :team
  validates_presence_of :type
  validates_presence_of :to_dest
  validates_presence_of :at_domain
  validates_presence_of :team
end
