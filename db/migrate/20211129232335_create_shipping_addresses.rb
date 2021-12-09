class CreateShippingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :zip_code,  null: false
      t.integer :state_id, null: false
      t.string :city, null: false
      t.string :address_1, null: false
      t.string :address_2
      t.string :phone_number, null: false
      t.references :purchase, null: false, foreign_key: true
      t.timestamps
    end
  end
end
