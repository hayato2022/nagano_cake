class Public::ItemsController < ApplicationController

  def index
    @genres = Genre.all
    @genre = Genre.find(params[:id])
  end

  def show
  end

end
