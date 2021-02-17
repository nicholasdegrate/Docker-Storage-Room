class CreatePlayerGames < ActiveRecord::Migration[5.2]
  def change
    create_table :player_games do |t|
      t.integer :points
      t.integer :player_id
      t.integer :game_id
      t.integer :wins
      t.integer :losses
    end
  end
end
