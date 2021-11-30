class Purchase < ApplicationRecord
  with_options null: false, foreign_key: true do
    validates :user
    validates :item
  end

  belongs_to :user
  has_one :shipping_address
  belongs_to :user
end
