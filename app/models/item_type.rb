class ItemType < ApplicationRecord
  has_many :category_groups, dependent: :destroy
  has_many :mediums, through: :category_groups

  validates :name, presence: true
end
