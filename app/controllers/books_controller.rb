class BooksController < ApplicationController
##確認のため############################
##一覧機能############################## 
  def index
    @books = Book.all
    @user = User.find_by(id: current_user.id) #本当はこれ書きたくない。
    #@p_user = User.find_by(id: book.user_id)
    @book = Book.new
  end
##詳細機能############################## チェック済
  def show
    @pbook = Book.find(params[:id])
    #@user = User.find(params[:id])　#これすると、Bookのidと同じ値でユーザーを呼び出すことになってしまう。
    @user = User.find_by(id: @pbook.user_id)
  end
##編集機能############################## 
  def edit
    @book = Book.find(params[:id])
    if @book.user_id == current_user.id
      render :edit
    else
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "You have updated book successfully."  
      redirect_to book_path(@book.id)
    else
      flash.now[:danger]
      render :edit
    end
  end
##投稿機能############################## 
  def create
    @book = Book.new(book_params)
    if @book.save 
     flash[:success] = "You have created book successfully."
     redirect_to book_path(@book.id)
    else 
     @books = Book.all
     flash.now[:danger]
     render :index
    end
  end
##削除機能##############################
  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:success] = ""
      redirect_to books_path
    end
  end
##ストロングパラメータ################## 
  private
  
  def book_params
    params.require(:book).permit(:title, :body).merge(user_id: current_user.id)
  end
  
end
