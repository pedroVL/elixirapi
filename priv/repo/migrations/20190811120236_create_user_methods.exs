defmodule Elixirapi.Repo.Migrations.CreateUserMethods do
  use Ecto.Migration

  def change do
    create table(:user_methods) do
      add :user_id, :integer #references(:users, on_delete: :nothing)
      add :method_id, :integer #references(:methods, on_delete: :nothing)

      timestamps()
    end

    create index(:user_methods, [:user_id])
    create index(:user_methods, [:method_id])
    # create unique_index(:book_authors, [:book_id, :author_id])

  end
end
