defmodule AdventOfCodeTest do
  use AdventOfCode.FileCase, async: true

  describe "day 1" do
    test "part 1" do
      assert AdventOfCode.Year2023.Day1.part_1(load_input_lines("day_1")) == nil
    end

    test "part 2" do
      assert AdventOfCode.Year2023.Day1.part_2(load_input_lines("day_1")) == nil
    end
  end

  describe "day 2" do
    test "part 1" do
      assert AdventOfCode.Year2023.Day2.part_1(load_input_lines("day_2")) == nil
    end

    test "part 2" do
      assert AdventOfCode.Year2023.Day2.part_2(load_input_lines("day_2")) == nil
    end
  end

  describe "day 3" do
    test "part 1" do
      assert AdventOfCode.Year2023.Day3.part_1(load_input("day_3")) == nil
    end

    test "part 2" do
      assert AdventOfCode.Year2023.Day3.part_2(load_input("day_3")) == nil
    end
  end

  describe "day 4" do
    test "part 1" do
      assert AdventOfCode.Year2023.Day4.part_1(load_input_lines("day_4")) == 21105
    end

    test "part 2" do
      assert AdventOfCode.Year2023.Day4.part_2(load_input_lines("day_4")) == 5_329_815
    end
  end
end
