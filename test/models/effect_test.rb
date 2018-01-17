require 'test_helper'

class EffectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @effect = build(:effect)
  end

  test'effect valid' do
    assert @effect.valid?
  end

  test "a effect must attached to strains" do
    @effect.save
    assert @effect.valid?
    refute_nil @effect.strains
  end

end
