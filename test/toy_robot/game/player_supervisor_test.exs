defmodule ToyRobot.Game.PlayerSupervisorTest do
  use ExUnit.Case, async: true

  alias ToyRobot.{Game.PlayerSupervisor, Robot}

  setup do
    {:ok, sup} = PlayerSupervisor.start_link([])
    {:ok, %{sup: sup}}
  end

  test "starts a child process", %{sup: sup} do
    robot = %Robot{east: 0, north: 0, facing: :north}
    {:ok, _player} = sup |> PlayerSupervisor.start_child(robot)
    %{active: active} = DynamicSupervisor.count_children(sup)

    assert active == 1
  end
end
