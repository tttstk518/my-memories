class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def active_for_authentication?
    super && (is_deleted == false)
  end
  has_many :favorites, dependent: :destroy
  has_many :articles, dependent: :destroy

  #正規表現によって、特定の文字を弾くようにする
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  #「presence: true」は記述することで、空で登録することを弾く

  #validates :is_deleted, presence: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = "123456"
      user.name = "guestuser"
    end
  end

  scope :latest, -> {order(created_at: :desc)}
  #orderデータの取り出し、Latest任意の名前で定義
  scope :old, -> {order(created_at: :asc)}
  scope :rate_count, -> {order(star: :desc)}

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
