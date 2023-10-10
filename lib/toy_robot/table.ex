defmodule ToyRobot.Table do
  alias ToyRobot.Table
  defstruct east_boundary: 4, north_boundary: 4

  @doc """
  Determine if a position is within boundaries

  ## Examples

      iex> alias ToyRobot.Table
      ToyRobot.Table
      iex> table = %Table{east_boundary: 4, north_boundary: 4}
      %Table{east_boundary: 4, north_boundary: 4}
      iex> table |> Table.valid_position?(%{north: 4, east: 4})
      true
      iex> table |> Table.valid_position?(%{north: 0, east: 0})
      true
      iex> table |> Table.valid_position?(%{north: 6, east: 0})
      false
  """
  def valid_position?(
        %Table{north_boundary: north_boundary, east_boundary: east_boundary},
        %{north: north, east: east}
      ) do
    north >= 0 && north <= north_boundary &&
      east >= 0 && east <= east_boundary
  end
end
