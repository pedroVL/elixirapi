defmodule ElixirapiWeb.BookController do
  use ElixirapiWeb, :controller

  alias Elixirapi.Auth
  alias Elixirapi.Auth.Book

  action_fallback ElixirapiWeb.FallbackController

  def index(conn, _params) do
    books = Auth.list_books()
    render(conn, "index.json", books: books)
  end

  def create(conn, %{"book" => book_params}) do
    with {:ok, %Book{} = book} <- Auth.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", book_path(conn, :show, book))
      |> render("show.json", book: book)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Auth.get_book!(id)
    render(conn, "show.json", book: book)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Auth.get_book!(id)

    with {:ok, %Book{} = book} <- Auth.update_book(book, book_params) do
      render(conn, "show.json", book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Auth.get_book!(id)
    with {:ok, %Book{}} <- Auth.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end
