class Item < ApplicationRecord

  VALID_INTEGER_REGEX = /\A[0-9]+\z/.freeze

  with_options presence: true do
    validates :name
    validates :description
    validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :condition_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :shipping_fee_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :state_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :days_to_ship_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :price, numericality: { less_than_or_equal_to: 9999999, greater_than_or_equal_to: 300 }
    validates :image
  end

  has_one_attached :image
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :days_to_ship
  belongs_to :state

end
