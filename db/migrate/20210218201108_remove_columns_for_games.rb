class RemoveColumnsForGames < ActiveRecord::Migration[5.2]
  def change
    change_table(:games) do |t|
      t.remove :player_id
      t.remove :player_game_id
    end
  end
end
