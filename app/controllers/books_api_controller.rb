class BooksApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authentication
  before_action :set_book, only: %i[ show update destroy ]

  def index
    @books = Book.all

    render json: @books
  end

  def show
    render json: @book
  end

  def create
    @book = Book.new(book_params)

    if @book.save!
      render json: { message: 'Successfully created', status: :created, location: @book }
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: { message: 'Successfully updated', data: @book}
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    render json: { message: "Successfully deleted #{@book.name} with id: #{@book.id}" }
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:name, :description, :pages, :author, :price)
    end
end  