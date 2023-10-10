defmodule ToyRobot.Game.Player do
  use GenServer

  def init(robot) do
    {:ok, robot}
  end

  def handle_call(:report, _from, robot) do
    {:reply, robot, robot}
  end
end
