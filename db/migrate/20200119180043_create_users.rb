class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :secret_question
      t.string :secret_answer
      t.timestamps null: false
    end
  end
end
