defmodule AdventOfCode.Day02 do
  def part1(args) do
    String.split(args, "\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn report -> Enum.map(report, &String.to_integer/1) end)
    |> Enum.map(&check_report(&1))
    |> Enum.count(fn x -> x end)
  end

  def check_report(levels, asc \\ nil, dampener \\ 0, prev \\ nil)

  def check_report(levels, _asc, _dampener, _prev) when length(levels) == 1 do
    true
  end

  def check_report(levels, asc, dampener, prev) do
    [left, right] = Enum.take(levels, 2)
    rest = Enum.drop(levels, 1)
    dif = abs(left - right)
    valid_dif = dif <= 3 and dif > 0

    cond do
      (asc == false or asc == nil) and left > right and valid_dif ->
        check_report(rest, false, dampener, left)

      (asc == true or asc == nil) and left < right and valid_dif ->
        check_report(rest, true, dampener, left)

      dampener > 0 ->
       drop_left =
        if prev == nil do
          rest
        else
          [prev | rest]
        end

        drop_right = [left | Enum.drop(rest,1)]

        asc = cond do
          rest == Enum.sort(rest, :asc) -> true
          rest == Enum.sort(rest, :desc) -> false
          true -> nil
        end

        check_report(drop_left, asc, dampener - 1 ) or check_report(drop_right, asc, dampener - 1)

      true ->
        false
    end
  end

  def part2(args) do
    String.split(args, "\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn report -> Enum.map(report, &String.to_integer/1) end)
    |> Enum.map(&check_report(&1, nil, 1))
    |> Enum.count(fn x -> x end)
  end
end
