class Category < ApplicationRecord
  scope :main_category, -> { where(main_category_id: nil) }
  scope :sub_category, -> (main){ where(sub_category_id: nil).where('main_category_id is not NULL').where(main_category: main) }
  scope :category, -> (sub){ where(sub_category: sub) }

  has_many :category, class_name: "Category",foreign_key: "main_category_id"
  has_many :category, class_name: "Category",foreign_key: "sub_category_id"
  belongs_to :main_category, class_name: "Category", optional: true
  belongs_to :sub_category, class_name: "Category", optional: true
  has_many :products
  has_ancestry
end
