class ItemField < ApplicationRecord
  has_many :field_groups, dependent: :destroy
  has_many :media, through: :field_groups
end
