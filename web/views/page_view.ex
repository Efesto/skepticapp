defmodule Skepticapp.PageView do
  use Skepticapp.Web, :view

  def pro_tweets_count do
    Skepticapp.Stash.pro_count()
  end

  def pro_tweets do
    Skepticapp.Stash.all()[:pro]
  end
end
