defmodule Goldcrest.Controller do
  import Plug.Conn

  def render(conn, :json, data) when is_map(data) do
    status = conn.status || 200

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Jason.encode!(data))
  end

  def redirect(conn, to: url) do
    body = redirection_body(url)
    status = conn.status || 302

    conn
    |> put_resp_header("location", url)
    |> put_resp_content_type("text/html")
    |> send_resp(status, body)
  end

  defp redirection_body(url) do
    html = Plug.HTML.html_escape(url)

    "<html><body>You are being <a href=\"#{html}\">
      redirected</a>" <>
      ".</body></html>"
  end
end
