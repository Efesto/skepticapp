defmodule Skepticapp.TweetChannel do
  use Skepticapp.Web, :channel

  def join("tweets", _params, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    register_socket(socket)
    {:noreply, socket}
  end

  def handle_info(_info, socket) do
    {:noreply, socket}
  end

  def broadcast_tweets(socket, tweets) do
    broadcast!(socket, "new_tweets", %{
      tweets: tweets,
      totalTweetsCount: Skepticapp.Stash.count()
    })
  end

  defp register_socket(socket) do
    Skepticapp.Sockets.add(socket)
  end
end
