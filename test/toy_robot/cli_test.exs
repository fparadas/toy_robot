defmodule ToyRobot.CLITest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

  test "provides usage instructions if no arguments specified" do
    output = capture_io(fn -> ToyRobot.CLI.main([]) end)

    assert output |> String.trim() == "Usage: toy_robot commands.txt"
  end

  test "provides usage instructions if too many arguments specified" do
    output = capture_io(fn -> ToyRobot.CLI.main(["one.txt", "two.txt"]) end)

    assert output |> String.trim() == "Usage: toy_robot commands.txt"
  end

  test "shows an error message if the file does not exist" do
    output = capture_io(fn -> ToyRobot.CLI.main(["one.txt"]) end)

    assert output |> String.trim() == "The file one.txt does not exist"
  end

  test "handles commands and reports successfully" do
    commands_path = Path.expand("assets/commands.txt", File.cwd!())

    output = capture_io(fn -> ToyRobot.CLI.main([commands_path]) end)

    expected_output = """
    The robot is at (0, 4) and is facing NORTH
    """

    assert output |> String.trim() == expected_output |> String.trim()
  end
end
