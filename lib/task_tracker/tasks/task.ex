defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :desc, :string
    field :done, :boolean, default: false
    field :name, :string
    field :time_taken, :integer, default: 0
    belongs_to :assigned_user, TaskTracker.Users.User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :desc, :done, :time_taken, :assigned_user_id])
    |> unique_constraint(:name)
    |> validate_required([:name, :desc])
  end
end
