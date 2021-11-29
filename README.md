# テーブル設計

## usersテーブル

| Column                | Type   | Options                    |
| --------------------- | ------ | -------------------------- |
| name                  | string | null: false                |
| email                 | string | null: false: unique: true  |
| encrypted_password    | string | null: false                |
| last_name             | string | null: false                |
| first_name            | string | null: false                |
| last_name_kana        | string | null: false                |
| first_name_kana       | string | null: false                |
| birthday_id           | date   | null: false                |

### Association

- has_many :items
- has_many :purchases





## itemsテーブル

| Column                      | Type       | Options                        |
| --------------------------- | ---------- | ------------------------------ |
| name                        | string     | null: false                    |
| description                 | text       | null: false                    |
| category_id                 | integer    | null: false                    |
| condition_id                | integer    | null: false                    |
| shipping_fee_id             | integer    | null: false                    |
| state_id                    | integer    | null: false                    |
| days_to_ship_id             | integer    | null: false                    |
| price                       | integer    | null: false                    |
| user                        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase





## purchasesテーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| user                  | references | null: false, foreign_key: true |
| product               | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- has_one :shipping_address
- belongs_to :user




## shipping_addressテーブル

| Column                  | Type       | Options                        |
| ----------------------- | ---------- | ------------------------------ |
| zip_code                | string     | null: false                    |
| state_id                | integer    | null: false                    |
| city                    | string     | null: false                    |
| address_1               | string     | null: false                    |
| address_2               | string     |                                |
| phone_number            | string     | null: false                    |
| purchase                | references | null: false, foreign_key: true |


### Association

- belongs_to :purchase
