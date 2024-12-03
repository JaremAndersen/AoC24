defmodule AdventOfCode.Day03 do
  # I have an irrational dislike of regex so I'm going to do this the hard way
  # Wow this is a lot worse than I thought it would be
  # Fine I guess regex isn't that bad
  # Shout out to Caleb, I stole your implementation to help debug this mess
  def part1(args) do
    String.split(args, "mul(", trim: true)
    |> Enum.map(fn x -> "~~~" <> x end)
    |> Enum.reject(fn x -> !String.contains?(x, ")") end)
    |> Enum.flat_map(fn mul -> String.split(mul, ")", trim: true) end)
    |> Enum.reject(fn x -> !String.contains?(x, "~~~") end)
    |> Enum.map(fn x -> String.replace(x, "~~~", "") end)
    |> Enum.map(fn x -> String.split(x, ",", trim: true) end)
    |> Enum.reject(fn x -> length(x) > 2 end)
    |> Enum.reject(fn x -> length(x) < 2 end)
    |> IO.inspect(limit: :infinity)
    |> Enum.flat_map(fn x ->
      Enum.map(x, fn i -> String.graphemes(i) end)
      |> Enum.map(fn j ->
        Enum.reduce_while(j, "", fn y, acc ->
          if String.length(acc) >= 3 do
            {:halt, "-1"}
          else
            cond do
              Integer.parse(y) != :error -> {:cont, acc <> y}
              String.length(acc) > 0 -> {:halt, "-1"}
              true -> {:cont, acc}
            end
          end
        end)
        |> Integer.parse(10)
        |> then(fn x ->
          case x do
            {x, _y} -> x
            :error -> nil
          end
        end)
      end)
      |> Enum.reject(fn x -> x == nil or x == "" end)
    end)
    |> Enum.chunk_every(2)
    |> Enum.reject(fn x -> Enum.any?(x, fn y -> y == -1 end) end)
    |> Enum.map(fn [x, y] -> x * y end)
    |> Enum.sum()
  end

  def part2(args) do
    String.replace(args, "don't()", "don't():skip)")
    |> String.replace("do()", "do():continue)")
    |> String.split(["mul(", "do()", "don't()"], trim: true)
    |> Enum.map(fn x -> "~~~" <> x end)
    |> Enum.reject(fn x -> !String.contains?(x, ")") end)
    |> Enum.flat_map(fn mul -> String.split(mul, ")", trim: true) end)
    |> Enum.reject(fn x -> !String.contains?(x, "~~~") end)
    |> Enum.map(fn x -> String.replace(x, "~~~","") end)
    |> Enum.map(fn x -> String.split(x, ",", trim: true) end)
    |> Enum.reject(fn x -> length(x) > 2  end)
    |> Enum.reject(fn x -> length(x) < 2 and x != [":skip"] and x != [":continue"] end)
    |> IO.inspect(limit: :infinity)
    |> Enum.reduce({[], :continue}, fn x, {acc, op} ->
      cond do
        x == [":skip"] -> {acc, :skip}
        x == [":continue"] -> {acc, :continue}
        op == :skip -> {acc, :skip}
        op == :continue -> {acc ++ [x], :continue}
      end
    end)
    |> elem(0)
    |> Enum.flat_map(fn x ->
      Enum.map(x, fn i -> String.graphemes(i) end)
      |> Enum.map(fn j ->
        Enum.reduce_while(j, "", fn y, acc ->
          if String.length(acc) >= 3 do
            {:halt, "-1"}
          else
            cond do
              Integer.parse(y) != :error -> {:cont, acc <> y}
              String.length(acc) > 0 -> {:halt, "-1"}
              true -> {:cont, acc}
            end
          end
        end)
        |> Integer.parse(10)
        |> then(fn x ->
          case x do
            {x, _y} -> x
            :error -> nil
          end
        end)
      end)
      |> Enum.reject(fn x -> x == nil or x == "" end)
    end)
    |> Enum.chunk_every(2)
    |> IO.inspect(limit: :infinity)
    |> Enum.reject(fn x -> Enum.any?(x, fn y -> y == -1 end) end)
    |> Enum.map(fn [x,y] -> x*y end)
    |> Enum.sum()
  end
end
