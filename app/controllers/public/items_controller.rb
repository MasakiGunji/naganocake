class Public::ItemsController < ApplicationController
  def index
    if params[:id]
      @items = Item.where(is_active: 1).where(genre_id: params[:id])
      @genre = Genre.find(params[:id])
    else
      @items = Item.where(is_active: 1)
    end
    @genres = Genre.where(is_active: 1)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
