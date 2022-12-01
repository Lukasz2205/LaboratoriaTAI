require 'csv'
require 'rails/all'
class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  # before_action :require_user

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to book_url(@book), notice: "Book was successfully created."
    else
      render :new, notice: 'Something went wrong'
    end
  end

  def update
    if @book.update(book_params)
      redirect_to book_url(@book), notice: "Book was successfully updated."
    else
      render :edit, notice: 'Something went wrong'
    end
  end

  def import_books
    csv_text = File.read(params[:books_file])
    puts 'asdasd'
    puts csv_text
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    count = 0 
    csv.each do |row|
      t = Book.new
      t.name        = row["Name"].nil? ? '' : row["Name"] 
      t.description = row["Description"].nil? ? '' : row["Description"] 
      t.pages       = row["Pages"].nil? ? 0 : row["Pages"]  
      t.author      = row["Author"].nil? ? '' : row["Author"] 
      t.price       = row["Price"].nil? ? 0 : row["Price"] 
      unless t.name.nil?
        if t.save 
          count += 1
        end 
      end 
    end 
    render json: { message: "Pomyślnie dodano #{count} nowe rekordy" }, status: :ok
  end 

  def export_books 
    @books = Book.all
    respond_to do |format|
      format.csv do 
        response.headers['Content-Type'] = 'text/csv'
        render template: "layouts/export_books"
      end 
    end 
  end 

  def destroy
    @book.destroy
    redirect_to books_url, notice: "Book was successfully destroyed."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :description, :pages, :author, :price)
  end
end
