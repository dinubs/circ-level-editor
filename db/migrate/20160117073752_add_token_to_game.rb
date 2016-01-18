class AddTokenToGame < ActiveRecord::Migration
  def change
    add_column :games, :token, :string
    add_index :games, :token, unique: true
  end
end
