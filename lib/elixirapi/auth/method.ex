defmodule Elixirapi.Auth.Method do
  use Ecto.Schema
  import Ecto.Changeset


  schema "methods" do
    field :function, :string
    field :method, :string

    timestamps()
  end

  @doc false
  def changeset(method, attrs) do
    method
    |> cast(attrs, [:function, :method])
    |> validate_required([:function, :method])
  end
end
