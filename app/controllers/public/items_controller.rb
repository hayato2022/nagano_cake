class Public::ItemsController < ApplicationController

  def index
    # サイドバーにジャンル一覧を表示させるために、ジャンルを全取得
    @genres = Genre.all

    # urlにgenre_idがある場合
    if params[:genre_id]

      # genreのデータベースから一致するidを取得する
      @genre = Genre.find(params[:genre_id])

      # genreと紐づく商品を取得
      @items = @genre.items.all

      # ジャンルをクリックした場合は、genreの名前
      @item_name = @genre.name
    else
      #商品をすべて取得
      @items = Item.all
      # クリックしていない場合は「商品」一覧
      @item_name = "商品"
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem
  end



  private

  def item_params
    params.requie(:item).permit(:genre_id, :name, :introduction, :price, :image )
  end

end
