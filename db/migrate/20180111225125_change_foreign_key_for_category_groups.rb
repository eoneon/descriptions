class ChangeForeignKeyForCategoryGroups < ActiveRecord::Migration[5.1]
  def change
    rename_column :category_groups, :media_id, :medium_id
  end
end
