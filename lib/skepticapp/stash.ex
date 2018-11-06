defmodule Skepticapp.Stash do
  use Agent
  @name __MODULE__

  def start_link() do
    {:ok, pid} = Agent.start_link(fn -> [] end, name: __MODULE__)

    :global.register_name(@name, pid)
    {:ok, pid}
  end

  def add(tweet) do
    Agent.update(agent_pid(), fn tweets ->
      tweets ++ [tweet]
    end)
  end

  def count() do
    Agent.get(agent_pid(), &length(&1))
  end

  def all() do
    Agent.get(agent_pid(), & &1)
  end

  defp agent_pid() do
    :global.whereis_name(@name)
  end
end
