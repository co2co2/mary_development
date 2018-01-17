require 'test_helper'

class StrainsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @strain = build(:strain)
  end

  test 'valid strain' do
   assert @strain.valid?
 end
end
