require 'test_helper'

class RecipeCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @recipe_category = build(:recipe_category)
  end

  test 'recipe_category factory working' do
   assert @recipe_category.valid?
  end

  test "one recipe_category can have many recipes " do
    assert  @recipe_category.recipes
  end

end
