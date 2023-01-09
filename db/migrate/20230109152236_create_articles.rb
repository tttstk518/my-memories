class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|

      t.timestamps
      t.boolean :is_delited, null: false
      t.integer :favorite, null: false
      t.string :text, nill: false
      t.string :title, nill: false
      t.integer :user_id, null: false
      t.string :image, nill: false
    end
  end
end
