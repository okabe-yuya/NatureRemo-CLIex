defmodule NatureRemoClient do
  @moduledoc """
  Documentation for `NatureRemoClient`.
  """

  import NatureRemoClient.CLI, only: [ run: 1 ]

  def main(argv) do
    parsed = run(argv)
    case send_signal(parsed) do
      { :ok, resp } -> status_format(resp.status_code, resp)
      { :error, _ } -> IO.puts("*** Unsupported CLI options😢. check README.md")
    end
  end

  defp status_format(200, _), do: IO.puts("*** Success NatureRemoAPI controll🎉")
  defp status_format(status_code, resp) do
    message = resp.body["message"] || "No message😫"
    IO.puts("status_code: #{status_code}. message: #{message}")
  end

  defp send_signal({ :error, {}, _ }), do: {:error, "Bad arguments! ※example: remo -d aircon on"}
  defp send_signal({ :device, { device, command, args }, _ }) do
    to_string = Atom.to_string(device) |> String.capitalize()
    String.to_existing_atom("Elixir.NatureRemoClient.Devices." <> to_string) |> apply(:execute, [command, args])
  end
end
