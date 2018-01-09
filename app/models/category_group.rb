class CategoryGroup < ApplicationRecord
  belongs_to :item_type
  belongs_to :media
end
