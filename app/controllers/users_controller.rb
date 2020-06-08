class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :new ]
	before_action :baria_user, only: [:update]

  def show
    @user = current_user
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
    @user =current_user
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
  	@user = User.find(params[:id])
    if @user != current_user
    redirect_to user_path(current_user)
    end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to users_path(@user), notice: "successfully updated user!"
  	else
  		render "show", notice: "error"
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end

end
