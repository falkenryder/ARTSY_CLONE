class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.integer :amount, null: false
      t.references :artwork, :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
