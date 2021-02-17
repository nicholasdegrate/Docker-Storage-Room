class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.integer :jersey_number
      t.integer :shoe_size
      t.integer :mvp
      t.datetime :dob
      t.integer :championship
      t.integer :team_id
      t.integer :manager_id
      t.integer :game_id
    end
  end
end
