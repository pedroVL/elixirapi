defmodule ElixirapiWeb.BookAuthorView do
  use ElixirapiWeb, :view
  alias ElixirapiWeb.BookAuthorView

  def render("index.json", %{book_authors: book_authors}) do
    %{data: render_many(book_authors, BookAuthorView, "book_author.json")}
  end

  def render("show.json", %{book_author: book_author}) do
    %{data: render_one(book_author, BookAuthorView, "book_author.json")}
  end

  def render("book_author.json", %{book_author: book_author}) do
    %{id: book_author.id}
  end
end
