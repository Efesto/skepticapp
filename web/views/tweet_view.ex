defmodule Skepticapp.TweetView do
  use Skepticapp.Web, :view

  def pro_tweets_count do
    Skepticapp.Stash.pro_count()
  end

  def against_tweets_count do
    Skepticapp.Stash.against_count()
  end

  def tweets do
    all = Skepticapp.Stash.all()
    Enum.take(all[:pro] ++ all[:against], -50)
  end

  def tweets_pro do
    all = Skepticapp.Stash.all()
    Enum.take(all[:pro], -50)
  end
end
