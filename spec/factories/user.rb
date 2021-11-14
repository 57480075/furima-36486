FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    name                    {Faker::Name.initials(number: 2)}
    email                   {Faker::Internet.free_email}
    password                {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation   {password}
    last_name               {person.last.kanji}
    first_name              {person.first.kanji}
    first_name_kana         {person.first.katakana}
    last_name_kana          {person.last.katakana}
    birthday_id             {Faker::Date.backward}
  end
end
