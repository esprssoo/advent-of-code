defmodule AdventOfCode.FileCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      defp load_input(name) do
        Path.expand("./support/#{name}.txt", __DIR__)
        |> File.read!()
      end
    end
  end
end
