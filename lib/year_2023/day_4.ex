defmodule AdventOfCode.Year2023.Day4 do
  def part_1(input) do
    parse(input)
    |> winnings()
    |> Enum.reduce(0, fn winning_set, total ->
      case MapSet.size(winning_set) do
        0 -> total
        size -> 2 ** (size - 1) + total
      end
    end)
  end

  def part_2(input) do
    input
    |> parse()
    |> winnings()
    |> Enum.with_index()
    |> Enum.map(fn {winnings, idx} -> {idx, {MapSet.size(winnings), 1}} end)
    |> Map.new()
    |> calculate_copies()
    |> Enum.reduce(0, fn {_, {_, count}}, acc -> count + acc end)
  end

  defp parse(input) do
    input
    |> Enum.map(fn line ->
      [_, cards] = String.split(line, ": ", trim: true, parts: 2)
      [winning, ours] = String.split(cards, " | ", parts: 2)
      winning = String.split(winning, " ", trim: true)
      ours = String.split(ours, " ", trim: true)
      {winning, ours}
    end)
  end

  defp winnings(cards) do
    Enum.map(cards, fn {winning, ours} ->
      winning_set = MapSet.new(winning)
      our_set = MapSet.new(ours)
      MapSet.intersection(winning_set, our_set)
    end)
  end

  defp calculate_copies(winnings) do
    len = map_size(winnings)

    for idx <- 0..(len - 1),
        points = elem(winnings[idx], 0),
        update_idx <- (idx + 1)..min(idx + points, len),
        points > 0,
        reduce: winnings do
      winnings ->
        Map.update!(winnings, update_idx, fn {points, count} ->
          {points, count + elem(winnings[idx], 1)}
        end)
    end
  end
end
