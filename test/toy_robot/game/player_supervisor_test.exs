defmodule ToyRobot.Game.PlayerSupervisorTest do
  use ExUnit.Case, async: true

  alias ToyRobot.{Game.PlayerSupervisor, Robot}

  test "starts a child process" do
    robot = %Robot{east: 0, north: 0, facing: :north}
    {:ok, player} = PlayerSupervisor.start_child(robot, "Izzy")

    [{registered_player, _}] = Registry.lookup(ToyRobot.Game.PlayerRegistry, "Izzy")
    assert registered_player == player
  end

  test "starts a registry" do
    registry = Process.whereis(ToyRobot.Game.PlayerRegistry)
    assert(registry)
  end

  test "moves a robot forward and reports its correct location" do
    robot = %Robot{east: 0, north: 0, facing: :north}
    {:ok, _player} = PlayerSupervisor.start_child(robot, "Charlie")
    :ok = PlayerSupervisor.move("Charlie")
    %{north: north} = PlayerSupervisor.report("Charlie")

    assert north == 1
  end

  test "reports a robot location" do
    robot = %Robot{east: 0, north: 0, facing: :north}
    {:ok, _player} = PlayerSupervisor.start_child(robot, "Davros")
    %{north: north} = PlayerSupervisor.report("Davros")

    assert north == 0
  end
end
