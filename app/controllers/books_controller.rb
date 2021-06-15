class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:update ]
  before_action :forbid_login_user, only: [:edit]
  before_action :set_book, only: [:index, :show, :edit]
  
  def forbid_login_user
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end

  def correct_user
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to root_path
    end
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      redirect_to book_path(@newbook.id)
      flash[:success] = "successfully"
    else
      @books = Book.all
      @user = @newbook.user
      render :index
      flash[:error] = "error"
    end

  end

  def index
    @book = Book.new
    @books = Book.all
    @user = @book.user
    flash[:success] = "successfully"
    flash[:error] = "error"
  end

  def show
    @books = Book.all
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
   @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:success] = "successfully"
    else
      render :edit
      flash[:error] = "error"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
    flash[:success] = "successfully"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def set_book 
    @newbook = Book.new
  end
end