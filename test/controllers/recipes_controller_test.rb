require 'test_helper'


class RecipesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @recipe = build(:recipe)
    @saved_recipe=create(:recipe,instructions: [build(:instruction)],measurements: [build(:measurement)])
  end
  #
  test "should get index" do
    get recipes_url
    assert_response :success
  end
  #
  test "should get new" do
    sign_in build(:user)
    get new_recipe_url
    assert_response :success
  end

  test "shouldn't get new" do
    get new_recipe_url
    assert_redirected_to user_session_url
  end

  # test "should create recipe" do
  #   sign_in build(:user)
  #   cat = create(:recipe_category)
  #   str = create(:strain)
  #   assert_difference('Recipe.count')
    # do

    #   post recipes_url, params: {
    #
    #     recipe:{
    #       id:70,
    #       recipe_category_id: cat.id,
    #       strain_name:str.name,
    #       strain_id:str.id,
    #       concentrate:0,
    #       title:"apple pie",
    #       image:"",
    #       video:"",
    #       description:"sjhdajkshdaskjhdjksa",
    #       prep_time:16,
    #       views:"",
    #       measurements_attributes:{
    #         "1516064928266"=>{
    #           "quantity"=>"1",
    #           "ingredient_attributes"=>{
    #             "name"=>"apple"
    #           },
    #         }
    #       },
    #       allergy:{
    #         '1':{name:nil},
    #         '2':{name:nil},
    #         '3':{name:nil},
    #         '4':{name:nil},
    #         '5':{name:nil}
    #       },
    #       instructions_attributes:{
    #         "0"=>{
    #           "step"=>"sdjahdjsahdsakhdkjash"
    #         }
    #       },
    #
    #     }
    #   }
    # end
    # assert_redirected_to recipe_url(Recipe.last)
  # end

  test "should show recipe" do
    get recipe_url(@saved_recipe)
    assert_response :success
  end
  #
  test "should get edit" do
    sign_in build(:user)
    get edit_recipe_url(@saved_recipe)
    assert_response :success
  end

  test "should update recipe" do

    sign_in build(:user)
    patch recipe_url(@saved_recipe), params: {
      recipe: {
         recipe_category_id: @saved_recipe.recipe_category_id,
         description: @saved_recipe.description,
         image: @saved_recipe.image,
         prep_time: @saved_recipe.prep_time,
         strain_id: @saved_recipe.strain_id,
         title: @saved_recipe.title,
         video: @saved_recipe.video,
         views: @saved_recipe.views,
         measurements_attributes:{
           "1516064928266"=>{
             "quantity"=>"3",
             "ingredient_attributes"=>{
               "name"=>"orange"
             },
           }
         },
         allergy:{
           '1':{name:"0"},
           '2':{name:true},
           '3':{name:true},
           '4':{name:"0"},
           '5':{name:"0"}
         },
         instructions_attributes:{
           "0"=>{
             "step"=>"try to update"
           },
           "1"=>{
             "step"=>"hope it works"
           }
         }
       }
    }

    assert_redirected_to recipe_url(@saved_recipe)
  end
  #
  test "should destroy recipe" do
    sign_in build(:user)
    assert_difference('Recipe.count', -1) do
      delete recipe_url(@saved_recipe)
    end

    assert_redirected_to recipes_url
  end


end
