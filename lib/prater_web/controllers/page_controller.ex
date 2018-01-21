defmodule PraterWeb.PageController do
  use PraterWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
