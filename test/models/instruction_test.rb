require 'test_helper'

class InstructionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @instruction = build(:instruction)
  end
  
  test "instruction must have step" do
    @instruction.save
    refute_nil @instruction.step
  end

end
