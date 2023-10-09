defmodule ToyRobot.Robot do
  alias ToyRobot.Robot
  defstruct north: 0, east: 0, facing: :north

  @doc """
  Moves the robot forward one space in the direction it is facing.
  ## Examples
      iex> alias ToyRobot.Robot
      ToyRobot.Robot
      iex> robot = %Robot{north: 0, facing: :north}
      %Robot{north: 0, facing: :north}
      iex> robot |> Robot.move
      %Robot{north: 1}
  """
  def move(%Robot{facing: :north} = robot), do: robot |> move_north
  def move(%Robot{facing: :east} = robot), do: robot |> move_east
  def move(%Robot{facing: :south} = robot), do: robot |> move_south
  def move(%Robot{facing: :west} = robot), do: robot |> move_west

  defp move_east(%Robot{east: east}) do
    %Robot{east: east + 1}
  end

  defp move_west(%Robot{east: east}) do
    %Robot{east: east - 1}
  end

  defp move_north(%Robot{north: north}) do
    %Robot{north: north + 1}
  end

  defp move_south(%Robot{north: north}) do
    %Robot{north: north - 1}
  end
end
