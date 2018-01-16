require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  setup do
    @recipe = build(:recipe)
    @newrecipe=create(:recipe, instructions: [build(:instruction)],measurements: [build(:measurement)])
  end

  test "requires a description" do
		@recipe.description = " "
		assert_not @recipe.valid?
	end
  test "description length should not be too short" do
    @recipe.description = "a" * 5
    assert_not @recipe.valid?
  end

  test "show error message for description" do
    @recipe.description = " "
    @recipe.save
    assert_equal(["can't be blank", "is too short (minimum is 6 characters)"], @recipe.errors[:description])
  end

  test "description length should not be too long" do
		@recipe.description = "a" * 501
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

  test 'only owner of recipe can delete' do
     @newrecipe.user != @user
     @newrecipe.destroy
     assert @newrecipe
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


  test "scope recent 3" do

    recipes = (0..6).map { |t| create(:recipe, instructions: [build(:instruction)],measurements: [build(:measurement)],created_at: t.days.from_now) }
    assert_equal [recipes[6], recipes[5],recipes[4]],  Recipe.recent
  end

  test "socpe user_favourites" do


  end

  test "top 3 most_favourite recipes" do

  end


  test "should report error" do
  assert_raises("InvalidInputError") do
     Recipe.new([recipe1['name'], recipe2['name'], recipe3['name']])

   end
 end


end
