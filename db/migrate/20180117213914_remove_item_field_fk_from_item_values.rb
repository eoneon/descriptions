class RemoveItemFieldFkFromItemValues < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :item_values, :item_fields
    remove_index :item_values, :item_field_id
  end
end
