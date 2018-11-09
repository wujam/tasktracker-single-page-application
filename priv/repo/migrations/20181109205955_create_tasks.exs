defmodule TaskTracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string
      add :desc, :text
      add :done, :boolean, default: false, null: false
      add :time_taken, :integer
      add :assigned_user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:tasks, [:assigned_user_id])
  end
end
