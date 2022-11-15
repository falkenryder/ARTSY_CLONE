class RenameUserForeignKey < ActiveRecord::Migration[7.0]
  def change
    rename_column :offers, :user_id, :buyer_id
  end
end
