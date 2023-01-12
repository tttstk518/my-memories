class Article < ApplicationRecord
    belongs_to :user

    validates :title,presence:true
    validates :body,presence:true,length:{maximum:200}
    validates :is_deleted, presence: true
    validates :favorite, presence: true
    validates :image, presence: true

end
