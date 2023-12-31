defmodule ToyRobot.Game.PlayerSupervisor do
  alias ToyRobot.Game.Player
  use DynamicSupervisor

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def move(name) do
    name |> Player.process_name() |> Player.move()
  end

  def turn_left(name) do
    name |> Player.process_name() |> Player.turn_left()
  end

  def turn_right(name) do
    name |> Player.process_name() |> Player.turn_right()
  end

  def report(name) do
    name |> Player.process_name() |> Player.report()
  end

  def init(_args) do
    Registry.start_link(keys: :unique, name: ToyRobot.Game.PlayerRegistry)
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(robot, name) do
    DynamicSupervisor.start_child(__MODULE__, {Player, [robot: robot, name: name]})
  end
end
