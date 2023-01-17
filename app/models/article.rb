class Article < ApplicationRecord
    belongs_to :user
    belongs_to :genre


    has_one_attached :image

    has_many :favorites, dependent: :destroy

    #公開・非公開機能
    scope :published, -> {where(is_deleted: true)}
    scope :unpublished, -> {where(is_deleted: false)}
    #scope:スコープの名前, ->{条件式}公開非公開見分ける条件式

    #既にブックマークしているかを検証
    def favorited_by?(user)
    favorites.where(user_id: user).exists?
    end

    def self.search(keyword)
     where(["genre like? OR genre_id like?", "%#{keyword}%", "%#{keyword}%"])
    end

    scope :latest, -> {order(created_at: :desc)}
    #orderデータの取り出し、Latest任意の名前で定義
    scope :old, -> {order(created_at: :asc)}
    scope :rate_count, -> {order(rate: :desc)}

    validates :title,presence:true
    validates :text,presence:true,length:{maximum:200}
    validates :is_deleted, inclusion: [true, false]
    validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true
end
