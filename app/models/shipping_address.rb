class ShippingAddress < ApplicationRecord



  belongs_to :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :state
end
