class BooksController < ApplicationController
  before_action :authenticate_user!
  def show
    @new_book = Book.new
  	@book = Book.find(params[:id])
    @books = Book.all
    @user = @book.user
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to books_path(@book.id), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
      redirect_to books_path,notice: "error"
  	end
  end

  def edit
  	@book = Book.find(params[:id])
    if @book.user_id != current_user.id
    redirect_to books_path
    end
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
      flash[:notice] = "error"
  		render "edit"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :profile_image)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
