class ValueGroup < ApplicationRecord
  belongs_to :item_field
  belongs_to :item_value
end
