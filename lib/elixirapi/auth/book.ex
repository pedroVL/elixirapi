defmodule Elixirapi.Auth.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixirapi.Auth.Author

  @timestamps_opts [type: Ecto.DateTime, usec: false]

  schema "book" do
    field :description, :string
    field :name, :string

    many_to_many(
      :authors,
      Author,
      join_through: "book_author",
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
