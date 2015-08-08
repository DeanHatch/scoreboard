class Groupingplace < ActiveRecord::Base

  belongs_to :grouping
  has_one :bracketcontestant, as: :bspec
  
end
