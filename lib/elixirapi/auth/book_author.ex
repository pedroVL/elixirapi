defmodule Elixirapi.Auth.BookAuthor do
  use Ecto.Schema
  import Ecto.Changeset


  schema "book_authors" do
    # #for some reason it is always failing when I try to get the keys
    # field(:book_id, :integer, null: false)
    # field(:author_id, :integer, null: false)
    
    belongs_to(:book, Book)
    belongs_to(:author, Author)
    timestamps()
  end

  @doc false
  def changeset(book_author, params) do
    book_author
    |> cast(params, [:book_id, :author_id])
    |> validate_required([:book_id, :author_id])
    |> foreign_key_constraint(:book_id)
    |> foreign_key_constraint(:author_id)
  end
end
