defmodule Elixirapi.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :firstname, :string
      add :lastname, :string

      timestamps()
    end

  end
end
