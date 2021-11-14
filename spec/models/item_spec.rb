require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品投稿" do
    context "商品投稿できる時" do
      it "name, description, category_id, condition_id, shipping_fee_id, state_id, days_to_ship_id, price, imageが存在すれば登録できる" do
        expect(@item).to be_valid
      end
      it "価格の値が300以上であれば登録できる" do
        @item.price = 300
        expect(@item).to be_valid
      end
      it "価格の値が9999999以下であれば登録できる" do
        @item.price = 9999999
        expect(@item).to be_valid
      end
      it "価格が半角数値であれば登録できる" do
        @item.price = 1111
        expect(@item).to be_valid
      end
    end
    context "商品投稿できないとき" do
      it "nameが空では登録できない" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "imageが空では登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "descriptionが空では登録できない" do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it "category_idの値が1では登録できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it "condition_idの値が1では登録できない" do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it "shipping_fee_idの値が1では登録できない" do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
      end
      it "state_idの値が0では登録できない" do
        @item.state_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("State can't be blank")
      end
      it "days_to_ship_idの値が1では登録できない" do
        @item.days_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Days to ship can't be blank")
      end
      it "priceの値が300より小さい値では登録できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it "priceの値が9999999より大きい値では登録できない" do
        @item.price = 1000000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it "priceの値が半角数値でなければ登録できない" do
        @item.price = "aaa"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "価格が空だと登録できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "userが紐付いていなければ出品できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end

# bundle exec rspec spec/models/item_spec.rb
