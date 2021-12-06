class Purchase < ApplicationRecord


  belongs_to :item
  has_one :shipping_address
  belongs_to :user
end
