defmodule Elixirapi.Repo.Migrations.CreateMethods do
  use Ecto.Migration

  def change do
    create table(:methods) do
      add :function, :string
      add :method, :string

      timestamps()
    end

  end
end
