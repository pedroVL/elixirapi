defmodule Elixirapi.Auth.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: Ecto.DateTime, usec: false]

  schema "book" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
