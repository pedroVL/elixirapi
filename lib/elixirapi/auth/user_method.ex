defmodule Elixirapi.Auth.UserMethod do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixirapi.Auth.User
  alias Elixirapi.Auth.Method

  @timestamps_opts [type: Ecto.DateTime, usec: false]

  schema "user_methods" do
    # field :user_id, :id
    # field :method_id, :id
    belongs_to(:user, User)
    belongs_to(:method, Method)
    timestamps()
  end

  @doc false
  def changeset(user_method, attrs) do
    user_method
    # |> cast(attrs, [:user_id, method_id])
    # |> validate_required([:user_id, method_id])
    # |> foreign_key_constraint(:user_id)
    # |> foreign_key_constraint(:method_id)
  end
end
