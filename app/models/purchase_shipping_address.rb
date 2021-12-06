class PurchaseShippingAddress
  include ActiveModel::Model
  attr_accessor :zip_code, :state_id, :city, :address_1, :address_2,:phone_number, :user_id, :item_id, :token

  VALID_POSTAL_CODE_REGEX = /\A\d{3}[-]\d{4}\z/
  VALID_PHONE_NUMBER_REGEX = /\A\d{10}$|^\d{11}\z/

  with_options presence: true do
    validates :user_id
    validates :item_id

    validates :token

    validates :zip_code, format: {with: VALID_POSTAL_CODE_REGEX,  message: "is invalid. Include hyphen(-)"}
    validates :state_id, numericality: {other_than: 0, message: "can't be blank"}
    validates :city
    validates :address_1
    validates :phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }
  end



  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(zip_code: zip_code, state_id: state_id, city: city, address_1: address_1, address_2: address_2 ,phone_number: phone_number, purchase_id: purchase.id)
  end
end
