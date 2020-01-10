defmodule ElixirTasks.GithubApiExample do
  @base_github_api_url "https://api.github.com"

  def user_programming_languages do
    IO.gets("Type username\n")
      |> String.trim
      |> get_request
  end

  defp get_request(username) do
    result = url_for(username)
      |> HTTPoison.get
      |> parse_response

    case result do
        {:ok, response} -> response
          |> collect_programming_languages
        :error -> "query error"
    end
  end

  defp url_for(username) do
    "#{@base_github_api_url}/users/#{username}/repos"
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> JSON.decode! |> success_response
  end

  defp parse_response(_) do
    :error
  end

  defp success_response(body) do
    {:ok, body}
  end

  def collect_programming_languages(response) do
    response
      |> Enum.map(fn res -> res["language"] end)
      |> Enum.uniq
      |> Enum.filter(fn res -> res != nil end)
  end
end
