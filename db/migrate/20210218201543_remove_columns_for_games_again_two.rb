class RemoveColumnsForGamesAgainTwo < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :player_id, :integer
    remove_column :games, :player_game_id, :integer
  end
end
