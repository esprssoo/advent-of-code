defmodule AdventOfCodeTest do
  use AdventOfCode.FileCase, async: true

  doctest AdventOfCode.Year2023.Day1

  describe "day 1" do
    test "part 1" do
      output =
        load_input("day_1")
        |> String.split("\n", trim: true)
        |> AdventOfCode.Year2023.Day1.part_1()

      assert output == 55172
    end

    test "part 2" do
      output =
        load_input("day_1")
        |> String.split("\n", trim: true)
        |> AdventOfCode.Year2023.Day1.part_2()

      assert output == 54925
    end
  end
end
