defmodule YoutubeCuck.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias YoutubeCuck.WorkerErrorHandler

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      YoutubeCuck.Repo,
      {Oban, Application.fetch_env!(:youtube_cuck, Oban)},
      # Start the Telemetry supervisor
      YoutubeCuckWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: YoutubeCuck.PubSub},
      # Start the Endpoint (http/https)
      YoutubeCuckWeb.Endpoint
      # Start a worker by calling: YoutubeCuck.Worker.start_link(arg)
      # {YoutubeCuck.Worker, arg}
    ]

    :telemetry.attach(
      "oban-errors",
      [:oban, :job, :exception],
      &WorkerErrorHandler.handle_event/4,
      nil
    )

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: YoutubeCuck.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    YoutubeCuckWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
