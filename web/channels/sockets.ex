defmodule Skepticapp.Sockets do
  use Agent
  @name __MODULE__

  def start_link() do
    {:ok, pid} = Agent.start_link(fn -> %{} end, name: __MODULE__)

    :global.register_name(@name, pid)
    {:ok, pid}
  end

  def add(socket) do
    Agent.update(agent_pid(), fn sockets ->
      Map.merge(sockets, %{socket.id => socket})
    end)
  end

  def all() do
    Agent.get(agent_pid(), & &1)
  end

  defp agent_pid() do
    :global.whereis_name(@name)
  end
end
