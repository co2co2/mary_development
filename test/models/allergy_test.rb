require 'test_helper'

class AllergyTest < ActiveSupport::TestCase
  setup do
    @allergy = Allergy.new
  end

  test"association with recipes"do
    assert @allergy.recipes
  end

end
