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
    
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
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
