class Public::ItemsController < ApplicationController

  def index
    @genres = Genre.all

    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.all
      @item_name = @genre.name
    else

      @items = Item.all
      @item_name = "商品"
    end
  end

  def show
  end

end
