class PurchasesController < ApplicationController

  before_action :authenticate_user!
  before_action :item_find, only: [:index, :create]

  def index
    if current_user.id == @item.user_id || @purchase_shipping_address
      redirect_to root_path
    else
      @purchase_shipping_address = PurchaseShippingAddress.new
    end
  end

  def create
    @purchase_shipping_address = PurchaseShippingAddress.new(purchase_params)
    if @purchase_shipping_address.valid?
      pay_item
      @purchase_shipping_address.save
      redirect_to root_path
    else
      render :index
    end
  end


  private

  def item_find
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:purchase_shipping_address).permit(:zip_code, :state_id, :city, :address_1, :address_2, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = "sk_test_4788e812eb3b4dedc98d6df1"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: purchase_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
