class CreateSubstrates < ActiveRecord::Migration[5.1]
  def change
    create_table :substrates do |t|
      t.string :substrate

      t.timestamps
    end
  end
end
