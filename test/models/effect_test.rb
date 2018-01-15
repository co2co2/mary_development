require 'test_helper'

class EffectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @effect = build(:effect)
  end

  test "a effect have many strains" do
    @effect.save
    assert @effect.valid?
    refute_nil @effect.strains
  end
end
