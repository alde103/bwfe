defmodule CowboyExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @port Application.compile_env(:cowboy_example, :port, 4040)

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: CowboyExample.Worker.start_link(arg)
      {Task, fn -> CowboyExample.Server.start(@port) end}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CowboyExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
