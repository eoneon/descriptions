class CreateItemValues < ActiveRecord::Migration[5.1]
  def change
    create_table :item_values do |t|
      t.string :name
      t.references :item_field, index: true, foreign_key: true

      t.timestamps
    end
  end
end
