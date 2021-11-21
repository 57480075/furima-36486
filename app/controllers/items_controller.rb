class ItemsController < ApplicationController


  before_action :get_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
    redirect_to new_user_session_path unless user_signed_in?
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def item_params
  params.require(:item).permit(:image, :description, :name, :references, :category_id, :condition_id, :shipping_fee_id, :state_id,
                                :days_to_ship_id, :price).merge(user_id: current_user.id)
  end

  def get_item
    @item = Item.find(params[:id])
  end
end
