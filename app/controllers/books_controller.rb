class BooksController < ApplicationController
  def new
    @books = Book.all
    @book = Book.new
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.save
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      flash[:alert]
      render :index, status: :unprocessable_entity
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def table
    @book = Book.find(params[:id])
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book  = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      flash[:alert]
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:notice] = "Book was successfully destroyd."
      redirect_to '/books'
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
