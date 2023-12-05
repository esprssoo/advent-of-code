defmodule AdventOfCode.FileCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      defp load_input(name) do
        Path.expand("./support/#{name}.txt", __DIR__)
        |> File.read!()
      end

      defp load_input_lines(name) do
        load_input(name)
        |> String.split("\n", trim: true)
      end
    end
  end
end
