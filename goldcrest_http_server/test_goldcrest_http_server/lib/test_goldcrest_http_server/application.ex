defmodule TestGoldcrestHTTPServer.Application do
  @moduledoc false
  use Application
  @port 4001
  @impl true
  def start(_type, _args) do
    children = [
      {Goldcrest.HTTPServer, [@port]}
    ]

    opts = [
      strategy: :one_for_one,
      name: TestGoldcrestHTTPServer.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end
end
