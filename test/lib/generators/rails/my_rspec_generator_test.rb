require 'test_helper'
require 'generators/rails/my_rspec/my_rspec_generator'

class Rails::MyRspecGeneratorTest < Rails::Generators::TestCase
  tests Rails::MyRspecGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
