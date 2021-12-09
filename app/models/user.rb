class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  VALID_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze

  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数を両方含む必要があります' }

  has_many :items
  has_many :purchases


  with_options presence: true do
    validates :name
    validates :last_name, format: { with: VALID_NAME_REGEX, message: 'は漢字,カタカナ,ひらがなを含む必要があります' }
    validates :first_name, format: { with: VALID_NAME_REGEX, message: 'は漢字,カタカナ,ひらがなを含む必要があります' }
    validates :last_name_kana, format: { with: VALID_KANA_REGEX, message: 'はカタカナである必要があります' }
    validates :first_name_kana, format: { with: VALID_KANA_REGEX, message: 'はカタカナである必要があります' }
    validates :birthday_id
  end
end
