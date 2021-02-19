class RemoveColumnsForPlayers < ActiveRecord::Migration[5.2]
  def change
    change_table(:players) do |t|
      t.remove :jersey_number
      t.remove :shoe_size
      t.remove :mvp
      t.remove :dob
      t.remove :championship
      t.remove :manager_id
      t.remove :game_id
    end
  end
end
