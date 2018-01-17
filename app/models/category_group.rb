class CategoryGroup < ApplicationRecord
  belongs_to :item_type
  belongs_to :medium
  attr_accessor :medium_ids
end
