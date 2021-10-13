class UsersController < ApplicationController
  def show
    #新規作成用のインスタンス変数を作成
    @book = Book.new
    #userに表示したいユーザーのidを与える
    @user = User.find(params[:id])
    #booksに表示したいユーザーに対応する本の一覧を与える
    @books = @user.books.page(params[:page]).reverse_order
  end

  def edit
    #userに編集したいユーザーのストロングパラメータを与える
    @user = User.find(params[:id])
    #現在のユーザーと編集対象のユーザーが異なれば現在のユーザーのページへリダイレクトする
    if @user.id != current_user.id
      flash[:notice]="権限がありません"
      redirect_to user_path(current_user.id)
    end
  end

  def update
    #userへidに対応したインスタンス変数を作成
    @user = User.find(params[:id])
    #更新後ののuser_paramsの内容を格納し、更新
    if @user.update(user_params)
      #成功した場合その旨のフラッシュメッセージを追加
      flash[:notice] = "update successfully"
      #Idに対応するuserのShow画面へリダイレクト
      redirect_to user_path(@user.id)
    else
      #失敗した場合はrenderを用いてリダイレクトする
      render :edit
    end
  end

  def index
    @book = Book.new
    @users = User.page(params[:page]).reverse_order
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
