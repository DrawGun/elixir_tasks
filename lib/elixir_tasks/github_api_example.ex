defmodule ElixirTasks.GithubApiExample do
  @default_username "drawgun"
  @base_github_api_url "https://api.github.com"

  def user_programming_languages do
    IO.gets("Type username\n")
      |> String.trim
      |> check_username_and_set_default
      |> get_request
      |> Enum.join(", ")
      |> IO.puts
  end

  defp check_username_and_set_default(username) do
    case username do
      "" -> @default_username
      _ -> username
    end
  end

  defp get_request(username) do
    IO.puts " HTTPoison.get: #{url_for_repos(username)}"

    result = url_for_repos(username)
      |> HTTPoison.get
      |> parse_response

    case result do
        {:ok, response} -> response
          |> collect_programming_languages
        :error -> ["query error"]
    end
  end

  defp url_for_repos(username) do
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
      |> Enum.map(&(&1["language"]))
      |> Enum.uniq
      |> Enum.filter(&(&1 != nil))
  end
end

