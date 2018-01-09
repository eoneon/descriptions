class CreateCategoryGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :category_groups do |t|
      t.references :item_type, index: true, foreign_key: true
      t.references :media, index: true, foreign_key: true

      t.timestamps
    end
  end
end
