defmodule Skepticapp.TweetController do
  use Skepticapp.Web, :controller

  def index(conn, _params) do
    session_id = get_session(conn, :user_session_id)

    conn =
      unless session_id do
        put_session(conn, :user_session_id, generate_session_id())
      else
        conn
      end

    render(assign(conn, :user_session_id, get_session(conn, :user_session_id)), "index.html")
  end

  defp generate_session_id() do
    :crypto.strong_rand_bytes(32) |> Base.encode64() |> binary_part(0, 32)
  end
end
