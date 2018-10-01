defmodule Skepticapp.Follower do
  use Task

  @twitter_client Application.get_env(:skepticapp, :twitter_api_module)

  def start_link(_) do
    topic = Application.get_env(:skepticapp, :topic)
    Task.start_link(fn -> follow(topic) end)
  end

  @spec follow(any()) :: [any()]
  def follow(topic) do
    stream =
      @twitter_client.stream_filter(track: topic)
      |> Stream.map(fn tweet -> Skepticapp.Stash.add_pro(tweet) end)

    Enum.to_list(stream)
  end
end
