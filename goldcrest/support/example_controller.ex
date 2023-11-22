defmodule Goldcrest.ExampleController do
  # Goldcrest.Controller should define all the helper functions
  import Goldcrest.Controller
  import Plug.Conn

  def call(conn, action: action) do
    apply(__MODULE__, action, [conn, conn.params])
  end

  def greet(conn, _params) do
    conn
    |> put_status(200)
    |> render(:json, %{data: "hello world"})
  end

  def redirect_greet(conn, _params) do
    conn
    |> redirect(to: "/greet")
  end
end
