defmodule Skepticapp.TweetsBroadcaster do
  use Task
  @polling_time 10000

  def start_link() do
    Task.start_link(fn -> broadcast(0) end)
  end

  def broadcast(next_tweet_index) do
    all_tweets = Skepticapp.Stash.all()

    tweets =
      all_tweets
      |> (&Enum.slice(&1, next_tweet_index, length(&1))).()

    Skepticapp.Sockets.all()
    |> Enum.each(fn {_id, socket} ->
      Skepticapp.TweetChannel.broadcast_tweets(socket, tweets)
    end)

    :timer.sleep(@polling_time)
    broadcast(length(all_tweets))
  end
end
