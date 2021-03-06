defmodule TaskTrackerWeb.PageController do
  use TaskTrackerWeb, :controller

  def index(conn, _params) do
    tasks = TaskTracker.Tasks.list_tasks()
    |> Enum.map(&(Map.take(&1, [:id, :name, :desc, :done, :time_taken, :assigned_user_id])))
    render conn, "index.html", tasks: tasks
  end
end
