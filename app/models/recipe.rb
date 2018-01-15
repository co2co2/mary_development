class Recipe < ApplicationRecord
  validates :recipe_category_id, :title, :description, :prep_time, :user_id, :instructions, :measurements, presence: true
  validates :title, length: { in: 3..100 }
  validates :description, length: { in: 6..500 }
  validates :prep_time, numericality: { only_integer: true}
  validates_each :instructions, :measurements do |record, attr, value|
    record.errors.add(attr, "Can't be blank") if value == ''
  end

  has_many :instructions, dependent: :destroy
  has_many :reviews
  has_many :favourites
  has_and_belongs_to_many :allergies
  accepts_nested_attributes_for :instructions, allow_destroy: true, :reject_if => :all_blank


	has_many :measurements, dependent: :destroy
	has_many :ingredients, through: :measurements
	accepts_nested_attributes_for :measurements, :reject_if => :all_blank,
	:allow_destroy => true
	accepts_nested_attributes_for :ingredients

  accepts_nested_attributes_for :allergies

	belongs_to :user
  belongs_to :recipe_category
  belongs_to :strain

  scope :concentrates, -> { where(concentrate: true)}
  scope :recent, -> { order('created_at DESC').limit(3) }


  scope :filter_ingredients, -> (ingredient_ids){ joins(:measurements).where("measurements.ingredient_id IN (?)", ingredient_ids).uniq}
 
  def self.filter_specific(ingredients)
    recipes_list = []
    ingredients.each do |ingredient_id| 
      recipes_list << Ingredient.find(ingredient_id).recipes
    end

    recipes_list.reduce &:&

  end

  def self.search(search)
    where("lower(title) LIKE ?", "%#{search.downcase}%")
  end

  def self.most_favourite
    Recipe.all.sort_by{|r| r.favourites.count}.reverse[0..2]
  end

  def strain_name
    strain.try(:name)
  end

  def strain_name=(name)
    self.strain = Strain.find_by(name: name) if name.present?
  end

    # Author.left_outer_joins(:posts).distinct.select('authors.*, COUNT(posts.*) AS posts_count').group('authors.id')

end
