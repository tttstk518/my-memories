class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article
  validates :user_id, uniqueness: { scope: :article_id }
  #重複しての登録を防ぐ
end
