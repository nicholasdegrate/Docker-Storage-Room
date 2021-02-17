class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.boolean :win_or_lost
      t.integer :player_id
      t.integer :player_game_id
    end
  end
end
