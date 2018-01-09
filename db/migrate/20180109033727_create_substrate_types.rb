class CreateSubstrateTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :substrate_types do |t|
      t.references :item_type, index: true, foreign_key: true
      t.references :substrate, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
