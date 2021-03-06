defmodule Skepticapp.Router do
  use Skepticapp.Web, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", Skepticapp do
    pipe_through(:browser)

    get("/", TweetController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", Skepticapp do
  #   pipe_through :api
  # end
end
