class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
      flash[:success] = "successfully"
    else
      @books = Book.all
      @user = @book.user
      render :index
      flash[:error] = "error"
    end
  end

  def index
    @book = Book.new
    @books = Book.find(Favorite.group(:book_id).where(created_at: Time.current.all_week).order('count(book_id) desc').pluck(:book_id))
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    @book_comments = @book.book_comments

    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end
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

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

end
