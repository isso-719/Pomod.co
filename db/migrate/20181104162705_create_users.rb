class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mail
      t.string :password_digest
      t.timestamps null: false
      t.string :user_icon
      t.string :user_gravatar
      t.string :user_timer_mode, default: "tomato"
      t.integer :goal, default: "0"
      t.string :errors
    end
  end
end
