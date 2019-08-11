defmodule ElixirapiWeb.BookAuthorControllerTest do
  use ElixirapiWeb.ConnCase

  alias Elixirapi.Auth
  alias Elixirapi.Auth.BookAuthor
  alias Elixirapi.Auth.Book
  alias Elixirapi.Auth.Author

  @create_attrs %{book_id: 1, author_id: 2}
  @update_attrs %{book_id: 2, author_id: 3}
  @invalid_attrs %{book_id: nil, author_id: nil}

  def fixture(:book_author) do
    {:ok, book_author} = Auth.create_book_author(@create_attrs)
    book_author
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all book_authors", %{conn: conn} do
      conn = get conn, book_author_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create book_author" do
    test "renders book_author when data is valid", %{conn: conn} do
      conn = post conn, book_author_path(conn, :create), book_author: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, book_author_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{book_id: 1, author_id: 2}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, book_author_path(conn, :create), book_author: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update book_author" do
    setup [:create_book_author]

    test "renders book_author when data is valid", %{conn: conn, book_author: %BookAuthor{id: id} = book_author} do
      conn = put conn, book_author_path(conn, :update, book_author), book_author: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, book_author_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{book_id: 2, author_id: 3}
    end

    test "renders errors when data is invalid", %{conn: conn, book_author: book_author} do
      conn = put conn, book_author_path(conn, :update, book_author), book_author: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete book_author" do
    setup [:create_book_author]

    test "deletes chosen book_author", %{conn: conn, book_author: book_author} do
      conn = delete conn, book_author_path(conn, :delete, book_author)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, book_author_path(conn, :show, book_author)
      end
    end
  end

  defp create_book_author(_) do
    book_author = fixture(:book_author)
    {:ok, book_author: book_author}
  end
end
