class FavoritesController < ApplicationController

    def create
        @book = Book.find(params[:book_id])
        favorite = current_user.favorites.new(book_id: @book.id)
        favorite.save

        respond_to do |format|
            format.html { redirect_to book_path(@book)}
            format.turbo_stream
        end
    end

    def destroy
        @book = Book.find(params[:book_id])
        favorite = current_user.favorites.find_by(book_id: @book.id)
        favorite.destroy if favorite

        respond_to do |format|
            format.html { redirect_to book_path(@book), status: :see_other }
            format.turbo_stream
        end
    end
end
