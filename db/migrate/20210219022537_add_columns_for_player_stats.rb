class AddColumnsForPlayerStats < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :stats, :text
  end
end
