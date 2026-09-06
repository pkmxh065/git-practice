class SearchesController < ApplicationController
    
    def index
        @query = params[:keyword]
        @target = params[:range]
        @method = params[:search]

        if @query.present?
            if @target == "User" || @target == "user"
                @users = search_for(User, "name", @query, @method)
            elsif @target == "Book" || @target == "book"
                @books = search_for(Book, "title", @query, @method)
            end
        else
            @users = User.none
            @books = Book.none
        end
    end

    private

    def search_for(model, column, query, method)
        case method
        when "perfect"
            model.where("#{column} = ?",query)
        when "forward"
            model.where("#{column} LIKE ?", "#{query}%")
        when "backward"
            model.where("#{column} LIKE ?", "#{query}%")
        when "partial"
            model.where("#{column} LIKE ?", "#{query}%")
        else        
            model.where("#{column} LIKE ?", "#{query}%")
        end
    end
end
