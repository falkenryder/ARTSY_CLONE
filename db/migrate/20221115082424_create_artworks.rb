class CreateArtworks < ActiveRecord::Migration[7.0]
  def change
    create_table :artworks do |t|
      t.string :artist_name, null: false
      t.string :title, null: false
      t.string :theme, null: false
      t.integer :year, null: false
      t.integer :price, null: false
      t.text :details, null: false
      t.references :users, index: true, foreign_key: true

      t.timestamps
    end
  end
end
