defmodule PraterWeb.Router do
  use PraterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PraterWeb do
    pipe_through :browser # Use the default browser stack

    get "/", RoomController, :index
    get "/rooms/new", RoomController, :new
    post "/rooms", RoomController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", PraterWeb do
  #   pipe_through :api
  # end
end
