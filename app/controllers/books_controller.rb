class BooksController < ApplicationController
    before_action :is_matching_login_user, only: [:edit, :update, :destroy]

    def new
        @book = Book.new
    end

    def index
        @books = Book.all
        @book = Book.new
        @user = current_user
    end

    def show
        @book = Book.new
        @book_detail = Book.find(params[:id])
        @user = @book_detail.user
        @book_coments = @book_detail.coments
        @book_coment = BookComent.new
    end

    def edit
        is_matching_login_user
        @book = Book.find(params[:id])
    end

    def create
        @book = Book.new(book_params)
        @book.user_id = Current.user.id
        if @book.save
            flash[:notice] = "You have created book successfully."
            redirect_to book_path(@book)
        else
            @books = Book.all
            @user = current_user
            render :index, status: :unprocessable_entity
        end
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            flash[:notice] = "You have update book successfully."
            redirect_to book_path(@book)
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path, status: :see_other
    end

    private

    def book_params
        params.require(:book).permit(:title, :body, :image)
    end

    def is_matching_login_user
        book = Book.find(params[:id])
        unless book.user_id == current_user.id
            redirect_to books_path
        end
    end
end
