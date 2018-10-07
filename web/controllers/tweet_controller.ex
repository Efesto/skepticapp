defmodule Skepticapp.TweetController do
  use Skepticapp.Web, :controller

  def index(conn, %{"position" => "pro"}) do
    render(conn, "pro.html")
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
