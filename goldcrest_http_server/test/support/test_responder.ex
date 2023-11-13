defmodule Goldcrest.TestResponder do
  import Goldcrest.HTTPServer.ResponderHelpers
  @behaviour Goldcrest.HTTPServer.Responder
  @impl true
  def resp(_req, method, path) do
    cond do
      method == :GET && path == "/hello" ->
        "Hello World"
        |> http_response()
        |> put_header("Content-type", "text/html")
        |> put_status(200)

      true ->
        "Not Found"
        |> http_response()
        |> put_header("Content-type", "text/html")
        |> put_status(404)
    end
  end
end
