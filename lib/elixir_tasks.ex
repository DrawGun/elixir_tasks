defmodule ElixirTasks do
  @moduledoc """
  Documentation for ElixirTasks.
  """

  @doc """
  Shows user programming languages.

  ## Examples

      iex> ElixirTasks.user_programming_languages()
      Type username
      drawgun
      ["Ruby", "JavaScript", "Elixir"]
  """

  def user_programming_languages() do
    ElixirTasks.GithubApiExample.user_programming_languages()
  end
end
