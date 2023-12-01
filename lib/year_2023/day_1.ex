defmodule AdventOfCode.Year2023.Day1 do
  def part_1(input), do: solve(input)
  def part_2(input), do: solve(input, :spelled)

  defp solve(input, flag \\ nil) do
    input
    |> Enum.flat_map(&[[left_digit(&1, flag), left_digit(String.reverse(&1), flag)]])
    |> Enum.map(&List.to_integer/1)
    |> Enum.sum()
  end

  defp left_digit(digits, flag \\ nil)
  defp left_digit(<<digit, _::binary>>, _) when digit in ?1..?9, do: digit
  defp left_digit(<<_, rest::binary>>, nil), do: left_digit(rest)

  defp left_digit(text, :spelled) do
    case text do
      "one" <> _ -> ?1
      "eno" <> _ -> ?1
      "two" <> _ -> ?2
      "owt" <> _ -> ?2
      "three" <> _ -> ?3
      "eerht" <> _ -> ?3
      "four" <> _ -> ?4
      "ruof" <> _ -> ?4
      "five" <> _ -> ?5
      "evif" <> _ -> ?5
      "six" <> _ -> ?6
      "xis" <> _ -> ?6
      "seven" <> _ -> ?7
      "neves" <> _ -> ?7
      "eight" <> _ -> ?8
      "thgie" <> _ -> ?8
      "nine" <> _ -> ?9
      "enin" <> _ -> ?9
      <<_, rest::binary>> -> left_digit(rest, :spelled)
    end
  end
end
