defmodule ToyRobot.Simulation do
  alias ToyRobot.{Robot, Table, Simulation}
  defstruct [:table, :robot]

  @doc """
  Simulates placing a robot on the table

  ## Examples

  When the robot is placed in a valid position:

      iex> alias ToyRobot.{Robot, Table, Simulation}
      [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
      iex> table = %Table{north_boundary: 4, east_boundary: 4}
      %Table{north_boundary: 4, east_boundary: 4}
      iex> Simulation.place(table, %{north: 0, east: 0, facing: :north})
      {
        :ok,
        %Simulation{
          table: table,
          robot: %Robot{north: 0, east: 0, facing: :north}
        }
      }

  When the robot is placed in a invalid position:

      iex> alias ToyRobot.{Robot, Table, Simulation}
      [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
      iex> table = %Table{north_boundary: 4, east_boundary: 4}
      %Table{north_boundary: 4, east_boundary: 4}
      iex> Simulation.place(table, %{north: 6, east: 0, facing: :north})
      {:error, :invalid_placement}
  """
  def place(table, placement) do
    if table |> Table.valid_position?(placement) do
      {
        :ok,
        %Simulation{
          table: table,
          robot: struct(Robot, placement)
        }
      }
    else
      {:error, :invalid_placement}
    end
  end

  @doc """
  Moves the robot forward one space in the direction that it is facing, unless that position is past the bou\
  ndaries of the table

  ## Examples

  ### A valid movement

      iex> alias ToyRobot.{Robot, Table, Simulation}
      [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
      iex> table = %Table{north_boundary: 4, east_boundary: 4}
      %Table{north_boundary: 4, east_boundary: 4}
      iex> simulation = %Simulation{
      ...>  table: table,
      ...>  robot: %Robot{north: 0, east: 0, facing: :north}
      ...> }
      iex> simulation |> Simulation.move
      {
        :ok,
        %Simulation{
          table: table,
          robot: %Robot{north: 1, east: 0, facing: :north}
        }
      }

  ### An invalida movement

      iex> alias ToyRobot.{Robot, Table, Simulation}
      [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
      iex> table = %Table{north_boundary: 4, east_boundary: 4}
      %Table{north_boundary: 4, east_boundary: 4}
      iex> simulation = %Simulation{
      ...>  table: table,
      ...>  robot: %Robot{north: 6, east: 0, facing: :north}
      ...> }
      iex> simulation |> Simulation.move
      {:error, :at_table_boundary}
  """
  def move(%Simulation{table: table, robot: robot} = simulation) do
    with moved_robot <- robot |> Robot.move(),
         true <- table |> Table.valid_position?(moved_robot) do
      {:ok, %{simulation | robot: moved_robot}}
    else
      false -> {:error, :at_table_boundary}
    end
  end

  @doc """
  Turns the robot to the left

  ## Examples

      iex> alias ToyRobot.{Robot, Table, Simulation}
      [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
      iex> table = %Table{north_boundary: 4, east_boundary: 4}
      %Table{north_boundary: 4, east_boundary: 4}
      iex> simulation = %Simulation{
      ...>  table: table,
      ...>  robot: %Robot{north: 0, east: 0, facing: :north}
      ...> }
      iex> simulation |> Simulation.turn_left
      {
        :ok,
        %Simulation{
          table: table,
          robot: %Robot{north: 0, east: 0, facing: :west}
        }
      }
  """
  def turn_left(%Simulation{robot: robot} = simulation) do
    {:ok, %{simulation | robot: robot |> Robot.turn_left()}}
  end

  @doc """
  Turns the robot to the right

  ## Examples

      iex> alias ToyRobot.{Robot, Table, Simulation}
      [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
      iex> table = %Table{north_boundary: 4, east_boundary: 4}
      %Table{north_boundary: 4, east_boundary: 4}
      iex> simulation = %Simulation{
      ...>  table: table,
      ...>  robot: %Robot{north: 0, east: 0, facing: :north}
      ...> }
      iex> simulation |> Simulation.turn_right
      {
        :ok,
        %Simulation{
          table: table,
          robot: %Robot{north: 0, east: 0, facing: :east}
        }
      }
  """
  def turn_right(%Simulation{robot: robot} = simulation) do
    {:ok, %{simulation | robot: robot |> Robot.turn_right()}}
  end

  @doc """
  Returns the robot current position

  ## Examples

      iex> alias ToyRobot.{Robot, Table, Simulation}
      [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
      iex> table = %Table{north_boundary: 4, east_boundary: 4}
      %Table{north_boundary: 4, east_boundary: 4}
      iex> simulation = %Simulation{
      ...>  table: table,
      ...>  robot: %Robot{north: 0, east: 0, facing: :north}
      ...> }
      iex> simulation |> Simulation.report
      %Robot{north: 0, east: 0, facing: :north}
  """
  def report(%Simulation{robot: robot}), do: robot
end
