class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:update ]
  before_action :forbid_login_user, only: [:edit]
  before_action :set_book

  def forbid_login_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to root_path
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.where(user_id: @user.id)
    @user_books = Book.where(use_id: @user.id, created_at: 0.day.ago.all_day)

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user)
      flash[:success] = "successfully"
    else
      render :edit
      flash[:error] = "error"
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def set_book
    @newbook = Book.new
  end

end
