
class Recipe < ApplicationRecord
  validates :category_id, :title, :description, :prep_time, :user_id, :instructions, :measurements, presence: true

  has_many :instructions, dependent: :destroy
  has_many :reviews
  has_many :favourites

  accepts_nested_attributes_for :instructions, allow_destroy: true, :reject_if => :all_blank


	has_many :measurements, dependent: :destroy
	has_many :ingredients, through: :measurements
	accepts_nested_attributes_for :measurements, :reject_if => :all_blank,
	:allow_destroy => true
	accepts_nested_attributes_for :ingredients

	belongs_to :user

  scope :concentrates, -> { where(concentrate: true)}
  scope :recent, -> { order('created_at DESC').limit(3) }
  

  def self.search(search)
    where("lower(title) LIKE ?", "%#{search.downcase}%")
  end


end
