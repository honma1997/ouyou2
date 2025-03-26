class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
  
    # すでにいいね済みかチェック（これが重要！）
    unless current_user.favorites.exists?(book_id: @book.id)
      @favorite = current_user.favorites.create(book_id: @book.id)
    end
  
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    @favorite = current_user.favorites.find_by(book_id: @book.id)

    # nil チェックを追加（エラー回避）
    @favorite.destroy if @favorite

    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js   # 非同期リクエストに対応
    end
  end
end
