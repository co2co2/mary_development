require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  setup do
    @recipe = build(:recipe)
  end

  test "description errors" do
    recipe1 = Recipe.new

    assert_not recipe1.valid?
    assert_equal(["can't be blank", "is too short (minimum is 6 characters)"], recipe1.errors[:description])
  end

  test "requires a description" do
    recipe = build(:recipe, description: nil).save
    refute(recipe)
  end

  test "requires a prep_time" do
    recipe = build(:recipe, prep_time: nil).save
    refute(recipe)
  end

  test "requires a recipe_category_id" do
    recipe = build(:recipe, recipe_category_id: nil).save
    refute(recipe)
  end

  test "requires a title" do
    recipe = build(:recipe, title: nil).save
    refute(recipe)
  end

end
