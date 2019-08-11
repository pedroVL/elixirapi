defmodule Elixirapi.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:book) do
      add :name, :string
      add :description, :text

      timestamps()
    end

  end
end
