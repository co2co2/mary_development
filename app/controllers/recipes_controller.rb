
class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: %i[index favourite show search_results filter]

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
      # INPUT ['eggs','oil']
      # array[0] EGGS inclusion
      # array[1] OIL inclusion
      # OUTPUT[[1,2,3,4][,5,6,7]]
      # if ingredient params length 2, length will be two
      accepted_ingredients = params[:ingredient].reject(&:blank?)
      @ingredient_set = Array.new(params[:ingredient].length)

      accepted_ingredients.each_with_index do |ingredient,i|

          @ingredients = Ingredient.where("lower(name) LIKE ?","%#{ingredient.singularize.downcase}%")
          # DO this if singularized ingredients are blank
          if @ingredients.blank?
            @ingredients = Ingredient.where("lower(name) LIKE ?","%#{ingredient.pluralize.downcase}%")
          end
          # DO this if plural ingredients and singular ingredients are NOT empty
          if !@ingredients.empty?
            # array of ingredient ids belonging to that category
            @ingredients_ids = []
            # loop through based on how many ingredients we got back
            @ingredients.each do |ingredient|
              # store each id in array
              @ingredients_ids << ingredient.id
            end #loop for ingredient LIKE query
          end #checked for nil object
            # set ingredient category to contain array of ingredient ids
            @ingredient_set[i] = @ingredients_ids

      end #looped all ingredients

      # checkbox
      if params[:specify]
        # AND search
        @recipes = Recipe.filter_specific(@ingredient_set)
      else
        # OR Search
        @recipes = Recipe.filter_ingredients(@ingredient_set.flatten)
      end
    else
      @recipes = Recipe.all.order("created_at DESC")
    end
  end

  def rate
    @recipe_rating = Rating.find_by(user_id: current_user.id, recipe_id: params[:recipe_id])

    if @recipe_rating != nil

      Rating.update(@recipe_rating.id ,rating: params[:rating])
    else
      @recipe_rating = current_user.ratings.build(recipe_id: params[:recipe_id], rating: params[:rating])
      @recipe_rating.save
    end
  end

  def favourite
    unless current_user
      redirect_to new_user_session_path, notice: 'you have to sign in first.'
      return
    end

    type = params[:type]
    if type == "favourite"
      @favourite = current_user.favourites.build(recipe_id: params[:recipe_id])
      @favourite.save
    else type == "unfavourite"
      @favourite = Favourite.where(user_id: current_user.id, recipe_id: params[:recipe_id])
      current_user.favourites.destroy(@favourite)
    end
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


    if @recipe.ratings.count != 0
       @avg_rating = 0
       @recipe.ratings.each do |recipe|
         @avg_rating += recipe.rating
      end

      @avg_rating = @avg_rating / (@recipe.ratings.count)
    end

    if user_signed_in?
      if Favourite.exists?(user_id: current_user.id, recipe_id: params[:id])
        # filled heart
        @favourite_link = "unfavourite"
      else
        # unfilled
        @favourite_link = "favourite"
      end
    else
      @favourite_link = "favourite"
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

      elsif Ingredient.find_by(name: ing_name)
        ingredient = Ingredient.find_by(name: ing_name)
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

   if params[:recipe][:concentrate] == '1' || params[:recipe][:recipe_category_id] == RecipeCategory.find_by(name: "Concentrates").id
     @recipe.concentrate = true
   else
     @recipe.concentrate = false
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

    if params[:recipe][:concentrate] == '1' || params[:recipe][:recipe_category_id] == RecipeCategory.find_by(name: "Concentrates").id
      @recipe.concentrate = true
    else
      @recipe.concentrate = false
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
