require 'test_helper'

class ValidTimeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
     
	#
   test "valid times are valid" do
	   [1, 24].each { |v| assert ! GameTime.new(v).tbd? }
	   [GameTime.earliest(), GameTime.latest()].each { |v| assert ! GameTime.new(v).tbd? }
   end

	#
   test "invalid times are not valid" do
	   [-1, 324].each { |v| assert GameTime.new(v).tbd? }
	   [GameTime.earliest()-1, GameTime.latest()+1].each { |v| assert GameTime.new(v).tbd? }
   end

end
