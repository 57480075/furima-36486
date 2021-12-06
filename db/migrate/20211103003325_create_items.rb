class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|

      t.string :name,     null: false
      t.text :description, null: false
      t.integer :category_id, null: false
      t.integer :condition_id, null: false
      t.integer :shipping_fee_id, null: false
      t.integer :state_id, null: false
      t.integer :days_to_ship_id, null: false
      t.integer :price, null: false
      t.references :user, null: false


      t.timestamps
    end
  end
end
