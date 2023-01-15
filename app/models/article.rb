class Article < ApplicationRecord
    belongs_to :user
    belongs_to :genre, dependent: :destroy
    
    has_one_attached :image
    
    has_many :favorites, dependent: :destroy
     
    #既にブックマークしているかを検証
    def favorited_by?(user)
    favorites.where(user_id: user).exists?
    end

    validates :title,presence:true
    validates :text,presence:true,length:{maximum:200}
    validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true

    #validates :is_deleted, presence: true
end
