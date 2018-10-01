defmodule Skepticapp.PageView do
  use Skepticapp.Web, :view

  def pro_tweets_count do
    Skepticapp.Stash.pro_count()
  end

  def pro_tweets do
    Enum.take(Skepticapp.Stash.all()[:pro], -50)
  end
end
