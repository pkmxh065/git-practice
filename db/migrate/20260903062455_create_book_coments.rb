class CreateBookComents < ActiveRecord::Migration[8.0]
  def change
    create_table :book_coments do |t|
      t.text :coment
      t.string :user_id
      t.string :book_id

      t.timestamps
    end
  end
end
