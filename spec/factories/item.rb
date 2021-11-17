FactoryBot.define do
  factory :item do
    name                  { Faker::Lorem.word }
    description           { Faker::Lorem.sentence }
    category_id           { Faker::Number.within(range: 2..11) }
    condition_id          { Faker::Number.within(range: 2..7) }
    shipping_fee_id       { Faker::Number.within(range: 2..3) }
    state_id              { Faker::Number.within(range: 1..48) }
    days_to_ship_id       { Faker::Number.within(range: 2..4) }
    price                 { Faker::Number.within(range: 300..9_999_999) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test.png'), filename: 'test.png')
    end
  end
end
