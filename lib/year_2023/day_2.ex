defmodule AdventOfCode.Year2023.Day2 do
  def part_1(input) do
    input
    |> Enum.map(&parse_input_line/1)
    |> Enum.filter(&possible_game?/1)
    |> Enum.reduce(0, fn {game_id, _}, acc -> String.to_integer(game_id) + acc end)
  end

  def part_2(input) do
    input
    |> Enum.map(&parse_input_line/1)
    |> Enum.map(&max_colors/1)
    |> Enum.reduce(0, fn %{red: red, green: green, blue: blue}, s -> red * green * blue + s end)
  end

  defp parse_input_line(line) do
    ["Game " <> game_id, game_data] = String.split(line, ": ", parts: 2)

    sets =
      game_data
      |> String.split("; ")
      |> Enum.map(fn set ->
        for cube <- String.split(set, ", "), into: %{"red" => 0, "green" => 0, "blue" => 0} do
          [count, color] = String.split(cube, " ", parts: 2)
          {color, String.to_integer(count)}
        end
      end)

    {game_id, sets}
  end

  defp possible_game?({_, sets}) do
    not Enum.any?(sets, fn set -> set["red"] > 12 or set["green"] > 13 or set["blue"] > 14 end)
  end

  defp max_colors({_, sets}) do
    Enum.reduce(
      sets,
      %{red: 0, green: 0, blue: 0},
      fn set, %{red: red, green: green, blue: blue} ->
        %{
          red: max(set["red"], red),
          green: max(set["green"], green),
          blue: max(set["blue"], blue)
        }
      end
    )
  end
end
