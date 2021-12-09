require 'rails_helper'

RSpec.describe PurchaseShippingAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_shipping_address = FactoryBot.build(:purchase_shipping_address, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end
  describe '商品購入機能' do

    context '商品を購入できる時' do
      it 'token, zip_code, state_id, city, address_1, phone_numberが存在していれば保存できる' do
        expect(@purchase_shipping_address).to be_valid
      end
      it 'address_2が空でも保存できる' do
        @purchase_shipping_address.address_2 = ''
        expect(@purchase_shipping_address).to be_valid
      end
    end

    context '商品を購入できない時' do
      it 'zip_codeが空では登録できない' do
        @purchase_shipping_address.zip_code = ""
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Zip code can't be blank")
      end
      it 'zip_codeにハイフン(-)が含まれていないと登録できない' do
        @purchase_shipping_address.zip_code = "1234567"
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include( "Zip code is invalid. Include hyphen(-)")
      end
      it 'zip_codeは「3桁ハイフン4桁」でないと登録できない' do
        @purchase_shipping_address.zip_code = "1234-123"
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
      end
      it "state_id(都道府県)に「---」が選択されている場合は登録できない" do
        @purchase_shipping_address.state_id = 0
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("State can't be blank")
      end
      it "cityが空では登録できない" do
        @purchase_shipping_address.city = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("City can't be blank")
      end
      it "address_1が空では登録できない" do
        @purchase_shipping_address.address_1 = ""
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Address 1 can't be blank")
      end
      it "phone_numberが空では登録できない" do
        @purchase_shipping_address.phone_number = ""
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number can't be blank", "Phone number is invalid")
      end
      it "phone_numberが9桁以下では登録できない" do
        @purchase_shipping_address.phone_number = "123456789"
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end
      it "phone_numberが12桁以上では登録できない" do
        @purchase_shipping_address.phone_number = "123456789012"
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end
      it "phone_numberが半角数値でないと登録できない" do
        @purchase_shipping_address.phone_number = "１２３"
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end
      it "tokenが空では登録できない" do
        @purchase_shipping_address.token = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
      it "userが紐付いていなければ購入できない"do
        @purchase_shipping_address.user_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("User can't be blank")
      end
      it "itemが紐付いていなければ購入できない" do
        @purchase_shipping_address.item_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
