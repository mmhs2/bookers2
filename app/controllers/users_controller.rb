class UsersController < ApplicationController
  ##一覧機能############################## 
  def index
    @users = User.all
    #binding.pry
    @user = User.find_by(id: current_user.id)
    #binding.pry
  end
  ##投稿機能############################## 
  def new
    @book = Book.new
  end
  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      flash[:success] = "You have created book successfully."
      redirect_to book_path(book.id)    
    else
      flash[:danger] = "can't be blank"
      redirect_to books_path
    end
    #binding.pry
  end
  ##詳細機能############################## 
  def show
    @user = User.find(params[:id])  #修正が必要かもしれん
    #@book = Book.find(params[:id])
    @books = Book.where(user_id: @user.id)
  end
  ##編集機能############################## 
  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] 
      render 'users/edit'
    end
    #binding.pry
  end
  ##ストロングパラメータ################## 
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)#.merge(user_id: current_user.id)
  end
  
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
  
end