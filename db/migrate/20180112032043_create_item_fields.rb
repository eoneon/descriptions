class CreateItemFields < ActiveRecord::Migration[5.1]
  def change
    create_table :item_fields do |t|
      t.string :field_type
      t.string :name
      
      t.timestamps
    end
  end
end
