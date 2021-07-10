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
    @users = User.all.page(params[:page]).reverse_order
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.where(user_id: @user.id)
    @today_books = Book.where(user_id: @user.id, created_at: Time.now.all_day)
    @daybefore_books = Book.where(user_id: @user.id, created_at: time.yesterday.all_day)


    this_day = Date.today
    this_saturday = this_day - (this_day.wday - 6)
    this_friday = this_day - (this_day.wday - 5)
    last_this_saturday = this_saturday - 7
    last_friday = this_friday - 7
    week_before_last_saturday = last_this_saturday - 7

    @thisweek_books = Book.where(user_id: @user.id, created_at: (last_this_saturday..this_friday))
    @lastweek_books = Book.where(user_id: @user.id, created_at: (week_before_last_saturday..0.days.ago.prev_week(:friday))

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
