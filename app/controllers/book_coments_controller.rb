class BookComentsController < ApplicationController
  before_action :is_matching_login_user, only: [:destroy]

  def create
    @book = Book.find(params[:book_id])
    @book_coment = current_user.book_coments.new(book_coment_params)
    @book_coment.book_id = @book.id
    
    if @book_coment.save
      @book_coments = @book.coments

      respond_to do |format|
        format.html { redirect_to book_path(@book) }
        format.turbo_stream
      end
    else
      @book_detail = book
      @book_coments = book.coments
      render 'books/show'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    book_coment = BookComent.find(params[:id])
    book_coment.destroy

    @book_coments = @book.coments

    respond_to do |format|
      format.html { redirect_to book_path(@book) }
      format.turbo_stream
    end
  end

  private

  def book_coment_params
    params.require(:book_coment). permit(:coment)
  end

  def is_matching_login_user
    book_coment = BookComent.find(params[:id])
    unless book_coment.user == Current.user
      redirect_to books_path
    end
  end
end
