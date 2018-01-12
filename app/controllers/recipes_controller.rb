class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: %i[index show search_results]

  def strain_name
    Strain.try(:name)
  end

  def strain_name=(name)
    self.strain = Strain.find_by(name: name) if name.present?
  end

  def search_results
    if params[:search]
      @recipes = Recipe.search(params[:search]).order("created_at DESC")
    else
      @recipes = Recipe.all.order("created_at DESC")
    end
  end

  def favourite
    type = params[:type]
    if type == "favourite"
      @favourite = current_user.favourites.build(recipe_id: params[:recipe_id])
      @favourite.save
      flash[:notice] = 'You have favourited this Recipe!'
    else type == "unfavourite"
      @favourite = Favourite.where(user_id: current_user.id, recipe_id: params[:recipe_id])
      current_user.favourites.delete(@favourite)
      flash[:notice] = 'You have unfavourited this Recipe!'
    end
    redirect_back(fallback_location: 'recipes#show')
  end

  # GET /recipes
  # GET /recipes.json
  def index
    if params[:search]
      @recipes = Recipe.search(params[:search]).order("created_at DESC")
    else
      @recipes = Recipe.all.order("created_at DESC")
    end
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @reviews = @recipe.reviews
    @review = Review.new
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
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
     params[:recipe][:allergy].each do |key,value|
      if value["name"] == "1"
          allergy = Allergy.find(key)
         @recipe.allergies << allergy
       end
    end
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
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

      params.require(:recipe).permit(:recipe_category_id, :strain_id, :title, :image, :video, :description, :prep_time, :views, :user_id, instructions_attributes:[:id, :recipe_id ,:step, :_destroy],
        allergies_attributes:[:id, :name],
        measurements_attributes:[:id, :ingredient_id, :recipe_id, :quantity, :_destroy,
        ingredient_attributes:[:id, :name, :concentrate_recipe_id, :_destroy]])

    end
end
