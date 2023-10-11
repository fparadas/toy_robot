defmodule ToyRobot.Game.Player do
  use GenServer

  alias ToyRobot.{Table, Simulation}

  def start_link(robot: robot, name: name) do
    GenServer.start_link(__MODULE__, robot, name: process_name(name))
  end

  def process_name(name) do
    {:via, Registry, {ToyRobot.Game.PlayerRegistry, name}}
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

  def turn_left(player) do
    GenServer.cast(player, :turn_left)
  end

  def turn_right(player) do
    GenServer.cast(player, :turn_right)
  end

  def handle_call(:report, _from, simulation) do
    {:reply, simulation |> Simulation.report(), simulation}
  end

  def handle_cast(instruction, simulation) do
    {:ok, new_simulation} =
      case instruction do
        :move -> simulation |> Simulation.move()
        :turn_left -> simulation |> Simulation.turn_left()
        :turn_right -> simulation |> Simulation.turn_right()
      end

    {:noreply, new_simulation}
  end
end
