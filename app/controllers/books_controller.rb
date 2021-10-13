class BooksController < ApplicationController
  def index
    #bookへ新規作成用のインスタンス変数を追加
    @book = Book.new
    #booksへすべての本の情報を追加
    @books = Book.page(params[:page]).reverse_order
  end

  def create
    #bookへ受け取ったフォームの内容を与える
    @book = Book.new(book_params)
    #登録用ユーザーIdを現在のユーザーのIdとする
    @book.user_id = current_user.id
    if @book.save
      #フォームの内容を保存しインスタンスメッセージを送信、その本のShow画面へ
      flash[:notice] = "create content successfully"
      redirect_to book_path(@book.id)
    else
      #もし保存できなければ本の一覧表示(Index)へ遷移
      #booksにすべての本の情報を与える
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.new
    #book_showへ表示したい本idのbookを格納
    @book_show = Book.find(params[:id])
  end

  #編集するBookを表示する為に対応するidのbookを格納
  def edit
    @book = Book.find(params[:id])
    #編集対象の本のユーザーが現在のユーザーでは無い場合
    if @book.user_id != current_user.id
      flash[:notice]="権限がありません"
      redirect_to books_path
    end
  end

  def destroy
    #bookに対応idのローカル変数を格納
    book = Book.find(params[:id])
    #削除し、成功した場合その旨のフラッシュメッセージを追加
    book.destroy
    flash[:notice] = "data delete successfully"
    #booksのページへリダイレクト
    redirect_to books_path
  end

  def update
    #bookへidに対応したインスタンス変数を作成
    @book = Book.find(params[:id])
    #更新後ののBook_paramsの内容を格納し、更新
    if @book.update(book_params)
      #成功した場合その旨のフラッシュメッセージを追加
      flash[:notice] = "update successfully"
      #Idに対応するBookのShow画面へリダイレクト
      redirect_to book_path(@book.id)
    else
      #失敗した場合はrenderを用いてリダイレクトする
      render :edit
    end

  end

    private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
