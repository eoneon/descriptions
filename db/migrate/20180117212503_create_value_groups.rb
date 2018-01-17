class CreateValueGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :value_groups do |t|
      t.references :item_field, index: true, foreign_key: true
      t.references :item_value, index: true, foreign_key: true

      t.timestamps
    end
  end
end
