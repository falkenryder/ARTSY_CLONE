class AddStatusColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :status, :string, null: false
  end
end
