defmodule ToyRobot.Game.Player do
  use GenServer

  alias ToyRobot.{Table, Simulation}

  def start_link(position) do
    GenServer.start_link(__MODULE__, position)
  end

  def start(position) do
    GenServer.start(__MODULE__, position)
  end

  def init(robot) do
    simulation = %Simulation{
      robot: robot,
      table: %Table{
        north_boundary: 4,
        east_boundary: 4
      }
    }

    {:ok, simulation}
  end

  def report(player) do
    GenServer.call(player, :report)
  end

  def move(player) do
    GenServer.cast(player, :move)
  end

  def handle_call(:report, _from, simulation) do
    {:reply, simulation |> Simulation.report(), simulation}
  end

  def handle_cast(:move, simulation) do
    {:ok, new_simulation} = simulation |> Simulation.move()
    {:noreply, new_simulation}
  end
end
