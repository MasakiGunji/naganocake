class Public::HomesController < ApplicationController
  def top
    @genres = Genre.where(is_active: 1)
    @items = Item.where(is_active: 1).limit(4)
  end

  def about
  end
end
