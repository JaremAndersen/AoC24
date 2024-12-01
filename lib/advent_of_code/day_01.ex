defmodule AdventOfCode.Day01 do
  def part1(args) do
    {left, right} =
      String.split(args, "\n", trim: true)
      |> Enum.map(fn row ->
        String.split(row, " ", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.reduce({[], []}, fn [a, b], {acc, acc2} ->
        {acc ++ [a], acc2 ++ [b]}
      end)

    left = Enum.sort(left)
    right = Enum.sort(right)

    Enum.with_index(left)
    |> Enum.reduce(0, fn {a, i}, acc ->
      acc + abs(a - Enum.at(right, i))
    end)
  end

  def part2(args) do
    {left, right} =
      String.split(args, "\n", trim: true)
      |> Enum.map(fn row ->
        String.split(row, " ", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.reduce({[], []}, fn [a, b], {acc, acc2} ->
        {acc ++ [a], acc2 ++ [b]}
      end)

    left = Enum.sort(left)
    right = Enum.sort(right)

    left
    |> Enum.map(fn a ->
      a * Enum.count(right, &(&1 == a))
    end)
    |> Enum.sum()
  end
end
