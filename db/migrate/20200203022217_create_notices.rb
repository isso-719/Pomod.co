class CreateNotices < ActiveRecord::Migration[5.2]
  def change
    create_table :notices do |t|
      t.string :title
      t.text :content
      t.timestamps null: false
    end
  end
end
