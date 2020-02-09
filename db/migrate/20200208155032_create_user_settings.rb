class CreateUserSettings < ActiveRecord::Migration[5.2]
  def change
      create_table :user_settings do |t|
      t.integer :goal
      t.references :user
      t.timestamps null: false
    end
  end
end
