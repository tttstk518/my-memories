class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

      t.timestamps
      t.integer :article_id, null: false
      t.integer :user_id, null: false
    end
  end
end
