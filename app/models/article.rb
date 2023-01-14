class Article < ApplicationRecord
    belongs_to :user
    belongs_to :genre, optional: true
     has_one_attached :image

    validates :title,presence:true
    validates :text,presence:true,length:{maximum:200}
    validates :rate, presence: true

    #validates :is_deleted, presence: true
end
