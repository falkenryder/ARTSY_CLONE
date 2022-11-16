class AddNameSurnametoUsers < ActiveRecord::Migration[7.0]
  def change
    add_column(:users, :first_name, :text, null: false)
    add_column(:users, :last_name, :text, null: false)
  end
end
