defmodule Skepticapp.Stash do
  use Agent
  @name __MODULE__

  def start_link(_) do
    {:ok, pid} = Agent.start_link(fn -> %{pro: [], against: []} end, name: __MODULE__)
    :global.register_name(@name, pid)
    {:ok, pid}
  end

  def add_pro(tweet) do
    Agent.update(agent_pid(), fn tweets ->
      Map.merge(tweets, %{pro: [tweet]}, merge_function())
    end)
  end

  def add_against(tweet) do
    Agent.update(agent_pid(), fn tweets ->
      Map.merge(tweets, %{against: [tweet]}, merge_function())
    end)
  end

  def pro_count() do
    Agent.get(agent_pid(), &length(&1[:pro]))
  end

  def all() do
    Agent.get(agent_pid(), & &1)
  end

  defp agent_pid() do
    :global.whereis_name(@name)
  end

  defp merge_function do
    fn _, v1, v2 -> v1 ++ v2 end
  end
end
