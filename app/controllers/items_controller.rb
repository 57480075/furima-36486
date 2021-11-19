class ItemsController < ApplicationController
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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    if user_signed_in?
      unless user_signed_in? && current_user.id == @item.user_id
        redirect_to root_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  # def destroy
  #   @item = Item.find(params[:id])
  #   if @item.destroy
  #     redirect_to root_path
  #   else
  #     render :show
  #   end
  # end

  private

  def item_params
  params.require(:item).permit(:image, :description, :name, :references, :category_id, :condition_id, :shipping_fee_id, :state_id,
                                :days_to_ship_id, :price).merge(user_id: current_user.id)
  end
end
