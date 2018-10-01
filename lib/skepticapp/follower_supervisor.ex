defmodule Skepticapp.FollowerSupervisor do
  use Supervisor

  def start(_, args) do
    start_link(args)
  end

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(_) do
    children = [
      Skepticapp.Stash,
      Skepticapp.Follower
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
