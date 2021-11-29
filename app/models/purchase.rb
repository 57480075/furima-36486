class Purchase < ApplicationRecord
  belongs_to :user
  has_one :shipping_address
  belongs_to :user
end
