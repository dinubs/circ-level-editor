class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :slug
      t.string :map
      t.integer :completions

      t.timestamps null: false
    end
    add_index :games, :slug, unique: true
  end
end
