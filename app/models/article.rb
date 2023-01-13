class Article < ApplicationRecord
    belongs_to :user
     has_one_attached :image

    validates :title,presence:true
    validates :text,presence:true,length:{maximum:200}
    #validates :is_deleted, presence: true
    validates :favorite, presence: true
    validates :image, presence: true

end
