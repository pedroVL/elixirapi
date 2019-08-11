defmodule Elixirapi.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixirapi.Auth.Method

  @timestamps_opts [type: Ecto.DateTime, usec: false]

  schema "users" do
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    many_to_many(
      :methods,
      Method,
      join_through: "user_method"
    )
    timestamps()
  end

    @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    |> put_password_hash()

  end

  defp put_password_hash(
    %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
      ) do
    change(changeset, password_hash: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset) do
    changeset
  end
end
