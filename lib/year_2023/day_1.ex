defmodule AdventOfCode.Year2023.Day1 do
  def part_1(input), do: solve(input)
  def part_2(input), do: solve(input, :spelled)

  defp solve(input, flag \\ nil) do
    input
    |> Enum.flat_map(fn item ->
      [[left_digit(item, flag), left_digit(String.reverse(item), flag, :reverse)]]
    end)
    |> Enum.reduce(0, fn num, acc -> List.to_integer(num) + acc end)
  end

  @word_nums ~w(one two three four five six seven eight nine)
  @word_nums_reverse Enum.map(@word_nums, &String.reverse/1)

  defp left_digit(digits, flag \\ nil, reverse \\ nil)
  defp left_digit(<<digit, _::binary>>, _, _) when digit in ?1..?9, do: digit
  defp left_digit(<<_, rest::binary>>, nil, _), do: left_digit(rest)

  for {word, idx} <- Enum.with_index(@word_nums) do
    defp left_digit(<<unquote(word), _::binary>>, :spelled, _),
      do: Integer.to_charlist(unquote(idx) + 1) |> List.first()
  end

  for {word, idx} <- Enum.with_index(@word_nums_reverse) do
    defp left_digit(<<unquote(word), _::binary>>, :spelled, :reverse),
      do: Integer.to_charlist(unquote(idx) + 1) |> List.first()
  end

  defp left_digit(<<_, rest::binary>>, :spelled, reverse), do: left_digit(rest, :spelled, reverse)
end
