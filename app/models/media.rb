class Media < ApplicationRecord
  has_many :category_groups, dependent: :destroy
  has_many :item_types, through: :category_groups
end
