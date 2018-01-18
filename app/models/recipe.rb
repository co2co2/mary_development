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
  scope :most_viewed, ->{ order('views DESC').limit(3) }
  scope :user_favourites, -> (user_id){ joins(:favourites).where("favourites.user_id = ?", user_id)}
  scope :filter_ingredients, -> (ingredient_ids){ joins(:measurements).where("measurements.ingredient_id IN (?)", ingredient_ids).uniq}
  mount_uploader :image, ImageUploader

  def self.filter_specific(ingredient_set)
    recipes_list = Array.new(ingredient_set.length)
    # ARCHAIC CODE
    # THIS CODE DOES NOT CONSIDER A LIST OF 'SAME NAME ' INGREDIENTS
    # ingredients.each do |ingredient_id|
    #   # Recipes list [x]contains array of recipes
    #   recipes_list << Ingredient.find(ingredient_id).recipes
    # end
    ingredient_set.compact.each_with_index do |ingredient,i|
      recipes_list[i] = Array.new(ingredient.length)
      ingredient.each_with_index do |ingredient_id,j|
        recipes_list[i][j] = Ingredient.find(ingredient_id).recipes
      end
    end
    # return recipes_list[0].flatten & recipes_list[1].flatten
    return recipes_list.map {|x| x.flatten}.reduce {|common,current| common & current}
    # Recipes_list
    # [x][x]
    # [y][y]
    # [z]
    # result = [x][y]
    #
    # what i want =
    # eggs   tomato
    # 0  1    0  1
    # [x][y] [x][b]
    # [z][a] [c][d]
    # result = [x]

    # ARCHAIC CODE
    # recipes_list.reduce &:&
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

  def minutes_to_hours(minutes)
    hours = minutes / 60
    minutes_remaining = minutes % 60

    if hours != 0 && hours !=1 && minutes_remaining != 0 && minutes_remaining != 1
      return "#{hours} hours and #{minutes_remaining} minutes"
    elsif hours != 0 && hours != 1 && minutes_remaining != 0
      return "#{hours} hours and #{minutes_remaining} minute"
    elsif hours != 0 && minutes_remaining != 0 && minutes_remaining != 1
      return "#{hours} hour and #{minutes_remaining} minutes"
    elsif hours != 0 && minutes_remaining != 0
      return "#{hours} hour and #{minutes_remaining} minute"
    elsif hours == 1
      return "#{hours} hour"
    elsif hours != 0 && hours != 1
      return "#{hours} hours"
    elsif minutes_remaining == 1
      return "#{minutes_remaining} minute"
    elsif minutes_remaining != 0 && minutes_remaining != 1
      return "#{minutes_remaining} minutes"
    end
  end

    # Author.left_outer_joins(:posts).distinct.select('authors.*, COUNT(posts.*) AS posts_count').group('authors.id')

end
