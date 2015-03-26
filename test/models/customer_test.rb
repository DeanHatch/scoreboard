require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
   test "no blank customers" do
     assert ! Customer.new.valid?
   end
end
