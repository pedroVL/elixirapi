defmodule ElixirapiWeb.BookAuthorController do
  use ElixirapiWeb, :controller

  alias Elixirapi.Auth
  alias Elixirapi.Auth.BookAuthor

  action_fallback ElixirapiWeb.FallbackController

  def index(conn, _params) do
    book_authors = Auth.list_book_authors()
    render(conn, "index.json", book_authors: book_authors)
  end

  def create(conn, %{"book_author" => book_author_params}) do
    with {:ok, %BookAuthor{} = book_author} <- Auth.create_book_author(book_author_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", book_author_path(conn, :show, book_author))
      |> render("show.json", book_author: book_author)
    end
  end

  def show(conn, %{"id" => id}) do
    book_author = Auth.get_book_author!(id)
    render(conn, "show.json", book_author: book_author)
  end

  def update(conn, %{"id" => id, "book_author" => book_author_params}) do
    book_author = Auth.get_book_author!(id)

    with {:ok, %BookAuthor{} = book_author} <- Auth.update_book_author(book_author, book_author_params) do
      render(conn, "show.json", book_author: book_author)
    end
  end

  def delete(conn, %{"id" => id}) do
    book_author = Auth.get_book_author!(id)
    with {:ok, %BookAuthor{}} <- Auth.delete_book_author(book_author) do
      send_resp(conn, :no_content, "")
    end
  end
end
