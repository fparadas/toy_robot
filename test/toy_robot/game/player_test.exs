defmodule ToyRobot.Game.PlayerTest do
  use ExUnit.Case, async: true

  alias ToyRobot.Game.Player
  alias ToyRobot.Robot

  describe "report" do
    setup do
      starting_position = %Robot{north: 0, east: 0, facing: :north}
      {:ok, player} = Player.start(starting_position)
      %{player: player}
    end

    test "shows the current position of the robot", %{player: player} do
      assert player |> Player.report() == %Robot{north: 0, east: 0, facing: :north}
    end
  end

  describe "move" do
    setup do
      starting_position = %Robot{north: 0, east: 0, facing: :north}
      {:ok, player} = Player.start(starting_position)
      %{player: player}
    end

    test "report after move shows the new position of the robot", %{player: player} do
      :ok = player |> Player.move()

      assert player |> Player.report() == %Robot{
               north: 1,
               east: 0,
               facing: :north
             }
    end
  end

  describe "turn" do
    setup do
      starting_position = %Robot{north: 0, east: 0, facing: :north}
      {:ok, player} = Player.start(starting_position)
      %{player: player}
    end

    test "report after turn left shows the robot facing west", %{player: player} do
      :ok = player |> Player.turn_left()

      assert player |> Player.report() == %Robot{
               north: 0,
               east: 0,
               facing: :west
             }
    end

    test "report after turn right shows the robot facing east", %{player: player} do
      :ok = player |> Player.turn_right()

      assert player |> Player.report() == %Robot{
               north: 0,
               east: 0,
               facing: :east
             }
    end
  end
end
