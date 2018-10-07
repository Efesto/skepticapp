defmodule Skepticapp.Follower do
  use Task

  @twitter_client Application.get_env(:skepticapp, :twitter_api_module)

  def start_link() do
    Task.start_link(fn -> follow() end)
  end

  def follow do
    stream =
      @twitter_client.stream_filter(track: topic())
      |> Stream.map(&filter_tweet(&1))

    Enum.to_list(stream)
  end

  def topic do
    Application.get_env(:skepticapp, :topic)
  end

  defp filter_tweet(tweet) do
    case tweet do
      %ExTwitter.Model.Tweet{
        retweeted_status: nil
      } ->
        handle_tweet(tweet)

      _ ->
        nil
    end
  end

  defp handle_tweet(tweet) do
    cond do
      String.contains?(tweet.user.name, "🇮🇹") -> Skepticapp.Stash.add_pro(tweet)
      String.contains?(tweet.user.name, "🇺🇸") -> Skepticapp.Stash.add_pro(tweet)
      true -> Skepticapp.Stash.add_against(tweet)
    end
  end
end
