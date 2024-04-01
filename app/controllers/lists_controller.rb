class ListsController < ApplicationController
  require "open-uri"
  require 'json'
  require 'net/http'


  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.save
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = @list.bookmarks
    # @bookmark = @bookmarks.find(params[:bookmark_id])
    # puts "Params: #{params.inspect}"


    # # @list = @bookmark.list
    # @bookmark.destroy
    # redirect_to list_path(@list), status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end

  def movie_params
    params.require(:movie).permit(:title, :overview, :poster_url, :rating)
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end
end
