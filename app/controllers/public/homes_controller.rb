class Public::HomesController < ApplicationController
  def top
    @items = Item.order("created_at DESC").limit(4)
    @genres = Genre.all
  end

  def about
  end

end
