defmodule Skepticapp.TweetView do
  use Skepticapp.Web, :view

  def tweets_count do
    Skepticapp.Stash.count()
  end
end
