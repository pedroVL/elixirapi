defmodule ElixirapiWeb.AuthorView do
  use ElixirapiWeb, :view
  alias ElixirapiWeb.AuthorView

  def render("index.json", %{authors: authors}) do
    %{data: render_many(authors, AuthorView, "author.json")}
  end

  def render("show.json", %{author: author}) do
    %{data: render_one(author, AuthorView, "author.json")}
  end

  def render("author.json", %{author: author}) do
    %{id: author.id,
      firstname: author.firstname,
      lastname: author.lastname}
  end
end
