defmodule NatureRemoClient.CustomClient do
  use HTTPoison.Base

  # Wrapped HTTPoison module and set custom for NatureRemo
  def process_request_url(endpoint) do
    "https://api.nature.global" <> endpoint
  end

  def process_request_headers(headers) do
    ["Content-Type": "application/x-www-form-urlencoded"]
      ++
    ["Authorization": access_token()]
      ++
    headers
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
  end

  defp access_token do
    token = System.get_env("NATURE_REMO_ACCESS_TOKEN")
    "Bearer #{token}"
  end
end
