class CreateFieldGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :field_groups do |t|
      t.references :item_field, index: true, foreign_key: true
      t.references :medium, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
