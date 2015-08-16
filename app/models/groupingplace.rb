class Groupingplace < ActiveRecord::Base

  belongs_to :grouping
  has_one :bracketcontestant, as: :bspec
  
    
  def label()
    [self.place.ordinalize,
     "Place",
     self.grouping.name()].join(' ')
  end
  
  def inspect()
    self.label()
  end
  

end
