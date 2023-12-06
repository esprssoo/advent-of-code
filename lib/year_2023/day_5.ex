defmodule AdventOfCode.Year2023.Day5 do
  def part_1(input) do
    {seeds, maps} = parse(input)

    Task.async_stream(chunks(10000, 10000), fn chunk ->
      Enum.reduce_while(chunk, 0, fn potential_location, _ ->
        if Enum.member?(seeds, find_seed_from_location(maps, potential_location)) do
          {:halt, potential_location}
        else
          {:cont, nil}
        end
      end)
    end)
    |> first_result()
  end

  def part_2(input) do
    {seeds, maps} = parse(input)

    seeds =
      seeds
      |> Enum.chunk_every(2, 2, :discard)
      |> Enum.map(fn [start, len] -> start..(start + len - 1) end)

    Task.async_stream(chunks(10000, 10000), fn chunk ->
      Enum.reduce_while(chunk, 0, fn potential_location, _ ->
        potential_seed = find_seed_from_location(maps, potential_location)

        if Enum.any?(seeds, &Enum.member?(&1, potential_seed)) do
          {:halt, potential_location}
        else
          {:cont, nil}
        end
      end)
    end)
    |> first_result()
  end

  defp find_seed_from_location(maps, initial_location) do
    Enum.reduce(maps, initial_location, fn map, location ->
      {_, diff} = Enum.find(map, {nil, 0}, fn {range, _} -> Enum.member?(range, location) end)
      location - diff
    end)
  end

  defp first_result(stream) do
    Enum.reduce_while(stream, nil, fn {:ok, result}, acc ->
      if result == nil, do: {:cont, acc}, else: {:halt, result}
    end)
  end

  defp chunks(chunk_size, mul, chunks \\ []) do
    case mul do
      -1 -> chunks
      mul -> chunks(chunk_size, mul - 1, [(chunk_size * mul)..(chunk_size * (mul + 1)) | chunks])
    end
  end

  defp parse(["seeds: " <> seeds | maps]) do
    seeds = String.split(seeds, " ", trim: true) |> Enum.map(&String.to_integer/1)
    maps = parse_maps(maps, [], [])

    {seeds, maps}
  end

  defp parse_maps([], ranges, maps), do: [ranges | maps]

  defp parse_maps([head | rest], ranges, maps) do
    if String.ends_with?(head, "map:") do
      maps = if Enum.empty?(ranges), do: maps, else: [ranges | maps]
      parse_maps(rest, [], maps)
    else
      [dest, src, len] = String.split(head, " ", trim: true) |> Enum.map(&String.to_integer/1)
      ranges = [{dest..(dest + len), dest - src} | ranges]
      parse_maps(rest, ranges, maps)
    end
  end
end
