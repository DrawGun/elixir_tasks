defmodule ElixirTasksTest do
  use ExUnit.Case
  doctest ElixirTasks

  test "greets the world" do
    assert ElixirTasks.hello() == :world
  end
end
