defmodule ToyRobot.Game.PlayerSupervisorTest do
  use ExUnit.Case, async: true

  alias ToyRobot.{Game.PlayerSupervisor, Robot}

  test "starts a child process" do
    robot = %Robot{east: 0, north: 0, facing: :north}
    {:ok, _player} = PlayerSupervisor.start_child(robot)
    %{active: active} = DynamicSupervisor.count_children(PlayerSupervisor)

    assert active == 1
  end
end
