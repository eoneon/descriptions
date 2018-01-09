class ItemType < ApplicationRecord
  has_many :category_groups, dependent: :destroy
  has_many :media, through: :category_groups

  validates :name, presence: true
end
