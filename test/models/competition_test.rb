require 'test_helper'

class CompetitionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "fixture competitions loaded correctly" do
	  #assert Competition.all.size == 3, "Should have been three loaded. #{Competition.all.size} were"
  end
  
  # Validations
  test "blank competition is not okay." do
	  assert ! Competition.new.valid?, "Should have not been validated."
  end
  
  # Initial Grouping Created Correctly
  test "new Competition has a Grouping." do
      # Create a new Competition that is an almost exact copy of an
      # existing Competition and then save it.
    newcomp = competitions(:bball).dup
    newcomp.name = "Slightly Different " + newcomp.name
    newcomp.id = competitions(:bball).id + 1 # new primary key value
    newcomp.save
    # The new Competition should be valid, should have been saved,
    # and should have created a new Grouping all on its own.
    assert newcomp.valid?, "Should be okay. Name is #{newcomp.name}"
    assert newcomp.groupings.size == 1, "#{newcomp.groupings.size} groupings loaded."
    # On the following save, no new Grouping should be created, should still be only one.
    newcomp.save
    assert newcomp.groupings.size == 1, "Whoa! How did we get #{newcomp.groupings.size} Groupings?"
  end
  
end
