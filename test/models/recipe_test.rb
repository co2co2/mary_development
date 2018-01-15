require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  setup do
    @recipe = build(:recipe)
  end

  test "requires a description" do
		@recipe.description = " "
		assert_not @recipe.valid?
    assert_equal(["can't be blank", "is too short (minimum is 6 characters)"], @recipe.errors[:description])
	end

  test "description length should not be too long" do
		@recipe.description = "a" * 500
		assert_not @recipe.valid?
  end

  test "requires a prep_time" do
    @recipe.prep_time = " "
		assert_not @recipe.valid?
    assert_equal(["can't be blank","is not a number"], @recipe.errors[:prep_time])
  end


  test "requires a recipe_category_id" do
    @recipe.recipe_category_id = " "
		assert_not @recipe.valid?
    assert_equal(["must exist"], @recipe.errors[:recipe_category])
  end

  test "requires a title" do
    @recipe.title = " "
		assert_not @recipe.valid?
    assert_equal(["can't be blank","is too short (minimum is 3 characters)"], @recipe.errors[:title])
  end

  test "title minimum 3 characters" do
    @recipe.title = "li"
		assert_not @recipe.valid?
    assert_equal(["is too short (minimum is 3 characters)"], @recipe.errors[:title])
  end

  test 'only owner of recipe can edit or delete' do
     @recipe.user != @user
     @recipe.destroy
     assert @recipe
   end

  test "must have instructions" do
    @recipe.instructions = []
    assert_not @recipe.valid?
  end

  test "must have measurements" do
    @recipe.measurements = []
    assert_not @recipe.valid?
    assert_equal(["can't be blank"], @recipe.errors[:measurements])
  end

  test "must have ingredients" do
    @recipe.ingredients = []
    assert_not @recipe.valid?
    assert @recipe.errors[:ingredients]
  end


  test "scope concentrates" do
    Recipe.concentrates.include?(@recipe)
    assert @recipe.concentrate = true
  end


  test "scope recent" do
    @newrecipe=create(:recipe, instructions: [build(:instruction)],measurements: [build(:measurement)])

    assert Recipe.recent.include?(@newrecipe)
  end

  test "should report error" do
  assert_raises("InvalidInputError") do
     Recipe.new([recipe1['name'], recipe2['name'], recipe3['name']])
   end
 end

end
