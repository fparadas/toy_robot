defmodule ToyRobot.Application do
  use Application

  def start(_types, _args) do
    children = [
      ToyRobot.Game.PlayerSupervisor
    ]

    opts = [strategy: :one_for_one, name: ToyRobot.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
