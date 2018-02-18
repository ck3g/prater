defmodule PraterWeb.RegistrationController do
  use PraterWeb, :controller
  alias Prater.Auth

  def new(conn, _params) do
    render conn, "new.html", changeset: conn
  end

  def create(conn, _params) do
  end
end
