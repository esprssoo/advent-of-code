defmodule AdventOfCode.Year2023.Day3 do
  def part_1(input) do
    {numbers, symbols} = parse(input)

    numbers
    |> Enum.filter(fn {coords, _} ->
      adjacent_symbols(coords, symbols) |> Enum.any?(fn adj -> adj != nil end)
    end)
    |> Enum.reduce(0, fn {_, number}, acc -> number + acc end)
  end

  def part_2(input) do
    {numbers, symbols} = parse(input)

    Enum.reduce(symbols, 0, fn
      {{x, y}, ?*}, total ->
        case adjacent_numbers({x, y}, numbers) do
          [a, b] -> a * b + total
          _ -> total
        end

      _, total ->
        total
    end)
  end

  defp parse(input) do
    grid =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&to_charlist/1)
      |> Enum.with_index()

    numbers =
      grid
      |> Enum.flat_map(fn {line, y} -> find_numbers(line, y) end)
      |> Map.new()

    symbols =
      grid
      |> Enum.flat_map(fn {line, y} -> find_symbols(line, y) end)
      |> Map.new()

    {numbers, symbols}
  end

  defp find_numbers(line, x \\ 0, y, numbers \\ [])
  defp find_numbers([], _, _, numbers), do: numbers

  defp find_numbers([s | rest], x, y, numbers) when s in [?-, ?+] do
    find_numbers(rest, x + 1, y, numbers)
  end

  defp find_numbers([_ | rest] = line, x, y, numbers) do
    case :string.to_integer(line) do
      {:error, _} ->
        find_numbers(rest, x + 1, y, numbers)

      {number, rest} ->
        len = length(line) - length(rest)
        find_numbers(rest, x + len, y, [{{x..(x + len), y}, number} | numbers])
    end
  end

  defp find_symbols(line, x \\ 0, y, symbols \\ [])
  defp find_symbols([], _, _, symbols), do: symbols

  defp find_symbols([s | rest], x, y, symbols) when s in ?0..?9 or s == ?. do
    find_symbols(rest, x + 1, y, symbols)
  end

  defp find_symbols([s | rest], x, y, symbols) do
    find_symbols(rest, x + 1, y, [{{x, y}, s} | symbols])
  end

  defp adjacent_symbols({x_range, y}, symbols) do
    x_range = Range.to_list(x_range)
    min_x = List.first(x_range)
    max_x = List.last(x_range)

    [
      symbols[{min_x - 1, y}],
      symbols[{max_x, y}],
      symbols[{min_x - 1, y + 1}],
      symbols[{min_x - 1, y - 1}]
      | Enum.flat_map(x_range, fn x ->
          [
            symbols[{x, y + 1}],
            symbols[{x, y - 1}]
          ]
        end)
    ]
  end

  defp adjacent_numbers({x, y}, numbers) do
    for y <- (y - 1)..(y + 1),
        x <- x..(x + 1),
        {{x_range, y_num}, num} <- numbers,
        x in x_range and y == y_num,
        uniq: true do
      num
    end
  end
end
