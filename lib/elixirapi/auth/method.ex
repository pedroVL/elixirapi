defmodule Elixirapi.Auth.Method do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixirapi.Auth.User

  @timestamps_opts [type: Ecto.DateTime, usec: false]

  schema "methods" do
    field :function, :string
    field :method, :string

    many_to_many(
      :users,
      User,
      join_through: "user_method"
    )

    timestamps()
  end

  @doc false
  def changeset(method, attrs) do
    method
    |> cast(attrs, [:function, :method])
    |> validate_required([:function, :method])
  end
end
