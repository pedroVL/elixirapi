defmodule Elixirapi.Repo.Migrations.CreateBookAuthors do
  use Ecto.Migration

  def change do
    create table(:book_authors) do
      add :book_id, :integer#references(:books, on_delete: :nothing)
      add :author_id, :integer#references(:authors, on_delete: :nothing)

      timestamps()
    end

    create index(:book_authors, [:book_id])
    create index(:book_authors, [:author_id])
    create unique_index(:book_authors, [:book_id, :author_id])

  end
end
