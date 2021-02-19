class AddUserIdColumnToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :user_id, :integer
  end
end
