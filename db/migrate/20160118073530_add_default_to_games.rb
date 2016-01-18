class AddDefaultToGames < ActiveRecord::Migration
  def change
    remove_column :games, :completions
    add_column :games, :completions, :integer, :default => 0
  end
end
