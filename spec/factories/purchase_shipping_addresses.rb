FactoryBot.define do
  factory :purchase_shipping_address do
    token {"tok_abcdefghijk00000000000000000"}

    zip_code { '123-4567' }
    state_id { 1 }
    city { '大阪市' }
    address_1 { '1-1-1' }
    address_2 { '架空ビル' }
    phone_number { '09012345678' }
  end
end
