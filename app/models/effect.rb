class Effect < ApplicationRecord
	has_and_belongs_to_many :strains

  scope :positives, -> { where(subcategory: "positive") }
  scope :medicals, -> { where(subcategory: "medical") }

end
