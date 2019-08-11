defmodule Elixirapi.Auth.Author do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: Ecto.DateTime, usec: false]

  schema "authors" do
    field :firstname, :string
    field :lastname, :string

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:firstname, :lastname])
    |> validate_required([:firstname, :lastname])
  end
end
