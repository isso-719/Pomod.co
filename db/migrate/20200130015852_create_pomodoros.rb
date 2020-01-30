class CreatePomodoros < ActiveRecord::Migration[5.2]
  def change
    create_table :pomodoros do |t|
      t.string :topic
      t.string :time
      t.string :did
      t.string :understand
      t.string :next
      t.references :user
      t.timestamps null: false
    end
  end
end
