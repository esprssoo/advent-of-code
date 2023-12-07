defmodule AdventOfCode.Year2023.Day6 do
  def part_1(input) do
    input
    |> Enum.map(fn input ->
      input
      |> String.split(":", trim: true, parts: 2)
      |> List.last()
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.zip()
    |> Enum.map(&solve/1)
    |> Enum.product()
  end

  def part_2(input) do
    input
    |> Enum.map(fn input ->
      input
      |> String.split(":", trim: true, parts: 2)
      |> List.last()
      |> String.replace(" ", "")
      |> String.to_integer()
    end)
    |> List.to_tuple()
    |> solve()
  end

  defp solve({time, distance}) do
    t1 = time * 0.5 - :math.sqrt(time * time - 4 * distance) * 0.5
    t2 = time * 0.5 + :math.sqrt(time * time - 4 * distance) * 0.5
    t1 = floor(t1)
    t2 = ceil(t2)
    t2 - t1 - 1
  end
end
