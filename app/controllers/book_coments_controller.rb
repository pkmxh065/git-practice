class BookComentsController < ApplicationController
  before_action :is_matching_login_user, only: [:destroy]

  def create
    book = Book.find(params[:book_id])
    coment = current_user.book_coments.new(book_coment_params)
    coment.book_id = book.id
    coment.save
    redirect_to book_path(book)
  end

  def destroy
    BookComent.find(params[:id]).destroy
    redirect_to book_path(params[:book_id])
  end

  private

  def book_coment_params
    params.require(:book_coment). permit(:coment)
  end

  def is_matching_login_user
    book_coment = BookComent.find(params[:id])
    unless book_coment.user == current_user
      redirect_to books_path
    end
  end
end
