class CreatePomodoros < ActiveRecord::Migration[5.2]
  def change
    create_table :pomodoros do |t|
      t.integer :time
      t.string :did
      t.string :understand
      t.string :next
      t.datetime :start
      t.datetime :stop
      t.references :user
      t.timestamps null: false
    end
  end
end
