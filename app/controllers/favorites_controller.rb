class FavoritesController < ApplicationController

    def create
        book = Book.find(params[:book_id])
        favorite = current_user.favorites.new(book_id: book.id)
        favorite.save
        redirect_to book_path(params[:book_id])
    end

    def destroy
        book = Book.find(params[:book_id])
        favorite = current_user.favorites.find_by(book_id: book.id)
        favorite.destroy if favorite
        redirect_to book_path(params[:book_id]), status: :see_other
    end
end
