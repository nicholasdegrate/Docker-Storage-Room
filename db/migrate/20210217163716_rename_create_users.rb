class RenameCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :rename_create_users do |t|
      t.string :name
      t.timestamps
    end
  end
end
