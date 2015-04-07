require 'test_helper'

class CompetitionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "fixture competitions loaded correctly" do
	  assert Competition.all.size == 2, "Should have been two loaded."
  end
  
  # Validations
  test "blank competition is not okay." do
	  assert ! Competition.new.valid?, "Should have not been validated."
  end
  
  # Initial Grouping Created Correctly
  test "new Competition has a Grouping." do
	  initial_grpngs = Grouping.all.size # before count should be one less than after
	    # Create a new Competition that is an almost exact copy of an
	    # existing Competition and then save it.
	  newcomp = competitions(:bball).dup
	  newcomp.name = "Different " + newcomp.name
	  newcomp.id = competitions(:bball).id + 1 # new primary key value
	  newcomp.save
	    # The new Competition should be valid, should have been saved,
	    # and should have created a new Grouping all on its own.
	  assert newcomp.valid?, "Should be okay. Name is #{newcomp.name}"
	  assert Competition.all.size == 3, "#{Competition.all.size} loaded."
	  grpngs_after_create = Grouping.all.size
	  assert initial_grpngs == (grpngs_after_create - 1), "Why #{grpngs_after_create} Groupings?"
	    # On the following save, no new Grouping should be created.
	  newcomp.save
	  grpngs_after_resave = Grouping.all.size
	  assert grpngs_after_create == grpngs_after_resave, "Whoa! How did we get #{grpngs_after_resave} Groupings?"
  end
  
end
