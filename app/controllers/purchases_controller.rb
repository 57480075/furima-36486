class PurchasesController < ApplicationController

  before_action :authenticate_user!
  before_action :item_find, only: [:index, :create]

  def index
    if current_user.id == @item.user_id || @item.purchase.present?
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
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
