defmodule Skepticapp.TweetChannel do
  use Skepticapp.Web, :channel
  @polling_time 10000

  def join("tweets", _params, socket) do
    send(self, :after_join)
    {:ok, "bravo", socket}
  end

  def handle_info(:after_join, socket) do
    start_listener(socket, 0)
    {:noreply, socket}
  end

  def handle_info(_info, socket) do
    {:noreply, socket}
  end

  def broadcast_tweets(tweets, socket) do
    broadcast!(socket, "new_tweets", %{
      tweets: tweets
    })
  end

  defp start_listener(socket, last_tweet_index) do
    Task.async(fn ->
      tweets =
        Skepticapp.Stash.all()[:against]
        |> (&Enum.slice(&1, last_tweet_index + 1, length(&1))).()

      broadcast_tweets(tweets, socket)

      :timer.sleep(@polling_time)
      start_listener(socket, length(tweets))
    end)
  end
end
