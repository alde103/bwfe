defmodule ExperimentServer do
  require Logger

  def start(port) do
    listener_options = [active: false, packet: :http_bin, reuseaddr: true]
    # listener_options = [active: false]

    {:ok, listen_socket} =
      :gen_tcp.listen(
        port,
        listener_options
      )

    Logger.info("Listening on port #{port}")

    listen(listen_socket)

    :gen_tcp.close(listen_socket)
  end

  # defp listen(listen_socket) do
  #   {:ok, connection_sock} = :gen_tcp.accept(listen_socket)
  #   {:ok, req} = recv(connection_sock)
  #   Logger.info("Got request: #{inspect(req)}")
  #   respond(connection_sock)
  #   listen(listen_socket)
  # end

  defp listen(listen_socket) do
    {:ok, connection_sock} = :gen_tcp.accept(listen_socket)
    {:ok, req} = :gen_tcp.recv(connection_sock, 0)
    {_http_req, method, {_type, path}, _v} = req
    Logger.info("Got request: #{inspect(req)}")
    respond(connection_sock, {method, path})
    listen(listen_socket)
  end

  # defp respond(connection_sock) do
  #   response = http_1_1_response("Hello World", 200)
  #   :gen_tcp.send(connection_sock, response)
  #   Logger.info("Sent response")
  #   :gen_tcp.close(connection_sock)
  # end

  defp http_1_1_response(body, status_code) do
    """
    HTTP/1.1 #{status_code}\r
    Content-Type: text/html\r
    Content-Length: #{byte_size(body)}\r
    \r
    #{body}
    """
  end

  # defp recv(connection_sock, messages \\ []) do
  #   case :gen_tcp.recv(connection_sock, 0) do
  #     {:ok, :http_eoh} ->
  #       Logger.info("""
  #       Got message: http_eoh
  #       """)

  #       {:ok, [:http_eoh | messages]}

  #     {:ok, message} ->
  #       Logger.info("""
  #       Got message: #{inspect(message)}
  #       """)

  #       recv(connection_sock, [message | messages])

  #     {:error, :closed} ->
  #       IO.puts("Socket closed")
  #       {:ok, messages}
  #   end
  # end

  defp respond(connection_sock, route) do
    response = get_response(route)
    :gen_tcp.send(connection_sock, response)
    Logger.info("Sent response")
    :gen_tcp.close(connection_sock)
  end

  defp get_response(route) do
    {body, status} = body_and_status_for(route)
    http_1_1_response(body, status)
  end

  defp body_and_status_for({:GET, "/hello"}) do
    {"Hello World", 200}
  end

  defp body_and_status_for(_), do: {"Not Found", 404}
end

ExperimentServer.start(4040)
