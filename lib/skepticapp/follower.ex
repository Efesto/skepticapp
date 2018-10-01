defmodule Skepticapp.Follower do
  use Task

  @twitter_client Application.get_env(:skepticapp, :twitter_api_module)

  def start_link(_) do
    Task.start_link(fn -> follow() end)
  end

  def follow do
    stream =
      @twitter_client.stream_filter(track: topic())
      |> Stream.map(fn tweet -> Skepticapp.Stash.add_pro(tweet) end)

    Enum.to_list(stream)
  end

  def topic do
    Application.get_env(:skepticapp, :topic)
  end
end
