class RenameForeignKey < ActiveRecord::Migration[7.0]
  def change
    rename_column :artworks, :users_id, :owner_id
  end
end
