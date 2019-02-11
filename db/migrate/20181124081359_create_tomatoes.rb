class CreateTomatoes < ActiveRecord::Migration[5.2]
  def change
    create_table :tomatoes do |t|
      t.references :user
      t.string :tomato_start_datetime
      t.string :tomato_end_datetime
      t.string :topic
      t.string :memo
      t.boolean :role, default: false
      t.timestamps null: false
    end
  end
end