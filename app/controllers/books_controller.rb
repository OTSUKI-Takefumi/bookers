class BooksController < ApplicationController
  def index#一覧
    @books = Book.all
    #入力フォームも存在する
    @book = Book.new
  end
  
  def create #保存

    #受け取る
    @book = Book.new(book_params)
    
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)

    else#保存失敗時には一覧ページを再表示
     @books = Book.all
     render :index
    end
  end
  
  def show#詳細
    @book = Book.find(params[:id])
  end
  
  def edit #編集
    @book = Book.find(params[:id])
  end

  def update #更新
    @book = Book.find(params[:id])

    if @book.update(book_params)#更新成功時にフラッシュメッセージを表示
       flash[:notice] = "Book was successfully updated."#
      redirect_to book_path(@book.id)

    else #失敗時にはリダイレクト
    render :edit
    end
  end

  def destroy #削除
    book = Book.find(params[:id])
    book.destroy

    #再表示
    redirect_to books_path
  end
  
  private
  #ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
