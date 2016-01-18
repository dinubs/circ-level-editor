class AddUserToGames < ActiveRecord::Migration
  def change
    add_column :games, :user_id, :integer, references: :users
  end
end
