
class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: %i[index show search_results filter]

  def strain_name
    Strain.try(:name)
  end

  def strain_name=(name)
    self.strain = Strain.find_by(name: name) if name.present?
  end

  def search_results
    # Search bar
    if params[:search]
      @recipes = Recipe.search(params[:search]).order("created_at DESC")
      # ingredient filter
    elsif params[:ingredient]
      # if ingredient params length 2, length will be two
      @ingredient_set = Array.new(params[:ingredient].length)
      @ingredients = []

      params[:ingredient].each_with_index do |ingredient,i|
        if !ingredient.empty?

          ingredient_id = Ingredient.where("lower(name) LIKE ?","%#{ingredient.singularize.downcase}%")
          # Query for egg
          # query for egg yolk
          # Query for eggs
          # youd get 3 ingredients
          if !ingredient_id.empty?
            @ingredients = []
            ingredient_id.each_with_index do |ingredient,j|
              @ingredients << ingredient.id
            end #loop for ingredient LIKE query
          end #checked for nil object
            @ingredient_set[i] = @ingredients
             #@ingredients[0][0]
               #@ingredients[0][1]
                #@ingredients[0][2]
                 #@ingredients[1][0]
               #@ingredients[1][1]
                #@ingredients[1][2]
        end#checked empty params
      end #looped ingredient params
      # test
      # ingredient_set[0-1]
      # ingredient[0-5]
      
      # checkbox
      if params[:specify]
        @recipes = Recipe.filter_specific(@ingredient_set)
      else
        @recipes = Recipe.filter_ingredients(@ingredients)
      end
    else
      @recipes = Recipe.all.order("created_at DESC")
    end
  end

  def filter

  end

  def favourite
    type = params[:type]
    if type == "favourite"
      @favourite = current_user.favourites.build(recipe_id: params[:recipe_id])
      @favourite.save
    else type == "unfavourite"
      @favourite = Favourite.where(user_id: current_user.id, recipe_id: params[:recipe_id])
      current_user.favourites.delete(@favourite)
    end
    # redirect_back(fallback_location: 'recipes#show')
  end


  def index
    # @recipes = Recipe.all.order("created_at DESC")
  end

  # GET /recipes/1
  def show
    @reviews = @recipe.reviews
    @review = Review.new
    @recipe.views += 1
    @recipe.save
    if user_signed_in?
      if Favourite.exists?(user_id: current_user.id, recipe_id: params[:id])
        @favourite_link = "unfavourite"
      else
        @favourite_link = "favourite"
      end
    end
  end

  # GET /recipes/new
  def new
    @recipe = current_user.recipes.build
    @concentrates = Recipe.concentrates
    @strain = Strain.all
    @allergies = Allergy.all


  end

  # GET /recipes/1/edit
  def edit
    @allergies = Allergy.all
  end

  # POST /recipes
  # POST /recipes.json

  def create

    @recipe = current_user.recipes.build(recipe_params)

  if params[:recipe][:measurements_attributes]
    # try to save ingredient unique, check if name exists in db
   params[:recipe][:measurements_attributes].keys.each_with_index do |k, i|
      ing_name = params[:recipe][:measurements_attributes][k][:ingredient_attributes][:name]
      if Ingredient.find_by(name: ing_name, concentrate_recipe_id: nil)
  
        ingredient = Ingredient.find_by(name: ing_name, concentrate_recipe_id: nil)
          @recipe.measurements[i].ingredient = ingredient
  
      end
    end
  end

   params[:recipe][:allergy].each do |key,value|
     if value["name"] == "1"
        allergy = Allergy.find(key)
       @recipe.allergies << allergy
     end
   end

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        @allergies = Allergy.all
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    @recipe.allergies.destroy_all
     params[:recipe][:allergy].each do |key,value|
      if value["name"] == "1"
          allergy = Allergy.find(key)
          @recipe.allergies << allergy
       end
      end

    respond_to do |format|
      if @recipe.update(recipe_params)
        @allergies = Allergy.all
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        @allergies = Allergy.all
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
    # Use callbacks to share common setup or constreaints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:recipe_category_id, :strain_id, :title, :image, :remove_image,:remote_image_url,:video, :description, :prep_time, :views, :user_id, instructions_attributes:[:id, :recipe_id ,:step, :_destroy],
        allergies_attributes:[:id, :name],
        measurements_attributes:[:id, :ingredient_id, :recipe_id, :quantity, :_destroy,
        ingredient_attributes:[:id, :name, :concentrate_recipe_id, :_destroy]])
    end


end
