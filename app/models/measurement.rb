class Measurement < ApplicationRecord
validates :quantity,:ingredient, presence: true
  belongs_to :recipe
  belongs_to :ingredient
  accepts_nested_attributes_for :ingredient,
                                :reject_if => :all_blank
end
