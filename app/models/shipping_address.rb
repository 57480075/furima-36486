class ShippingAddress < ApplicationRecord
  with_options presence: true do
    validates :zip_code
    validates :state_id
    validates :city
    validates :address_1
    validates :phone_number
    validates :purchase, foreign_key: true
  end

  validates :address_2

  belongs_to :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :state
end
