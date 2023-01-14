class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|

      t.timestamps
      t.boolean :is_deleted, null: false
      t.float :rate, null: false
      t.string :text, nill: false
      t.string :title, nill: false
      t.integer :user_id, null: false
      t.string :image, nill: false
      t.string :genre_id, null: false
    end
  end
end
