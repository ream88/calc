defmodule Calc do
  # public API

  def add(pid, value) do
  end

  def minus(pid, value) do
  end

  def value(pid) do
  end

  # private API

  def start() do
    loop(0)
  end

  defp loop(state) do
    state =
      receive do
        {:+, value} when is_number(value) ->
          state + value

        {:-, value} when is_number(value) ->
          state - value

        {:print, pid} ->
          send(pid, state)
      end

    loop(state)
  end
end
