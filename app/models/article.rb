class Article < ApplicationRecord
    belongs_to :user
    validates :is_deleted, presence: true
    validates :favorite, presence: true
    validates :image, presence: true
end
