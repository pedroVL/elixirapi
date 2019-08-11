defmodule Elixirapi.Auth.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixirapi.Auth.Book

  @timestamps_opts [type: Ecto.DateTime, usec: false]

  schema "authors" do
    field :firstname, :string
    field :lastname, :string

    many_to_many(
      :books,
      Book,
      join_through: "book_author"
    )

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:firstname, :lastname])
    |> validate_required([:firstname, :lastname])
  end
end
