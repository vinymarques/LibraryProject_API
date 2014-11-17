class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :edit]
  # skip_before_filter :http_basic_authenticate, only: [:index]

  def index
    @books = Book.order('created_at DESC').page(params[:page]).per_page(10).search(params[:search], params[:id])
    respond_to do |format|
      format.json
      format.html
    end
  end

  def show
    @book = Book.find(params[:id])
    respond_to do |format|
      format.json
      format.html
    end
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    books = Book.all
    current_nome = book_params[:nome]
    current_autor = book_params[:autor]
    current_qtd = book_params[:quantidade_estoque].to_i

    if Book.last
      books.each do |b|
        if b.nome == current_nome && b.autor == current_autor
          if current_qtd >=1
            b.update(quantidade_estoque: b.quantidade_estoque.to_i+current_qtd.to_i)
            redirect_to books_url, notice: 'Livro já existente, estoque expandido'
          else
            redirect_to books_url, notice: 'Livro já existente'
          end
          break
        elsif b == (Book.last)
          save_book
        end
      end
    else
      save_book
    end
  end

  def update
    books = Book.all
    current_nome = book_params[:nome]
    current_autor = book_params[:autor]
    current_qtd = book_params[:quantidade_estoque].to_i
    current_id = params[:id]

    books.each do |b|
      if b.nome == current_nome && b.autor == current_autor && (b.id != current_id.to_i)
        redirect_to edit_book_url, notice: 'Livro já existente'
        break
      elsif b == (Book.last)
        update_finish_book
      end
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Livro removido' }
      format.json { head :no_content }
    end
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:nome, :autor, :descricao, :quantidade_estoque)
    end

    def save_book
      @book = Book.new(book_params)
      respond_to do |format|
        if @book.save
          format.html {redirect_to @book, notice: 'Livro registrado com sucesso'}
          format.json { render :show, status: :created, location: @book }
        else
          format.html {render action: 'new'}
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    end

    def update_finish_book
      @book = Book.find(params[:id])
      respond_to do |format|
        if @book.update(book_params)
          format.html { redirect_to @book, notice: 'Livro modificado'}
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render action: 'edit'}
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    end
end
