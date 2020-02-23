class CreateTodos < ActiveRecord::Migration[5.2]
  def change
      create_table :todos do |t|
      t.string :content
      t.datetime :deadline
      t.boolean :status, default: false
      t.references :user
      t.timestamps null: false
    end
  end
end
