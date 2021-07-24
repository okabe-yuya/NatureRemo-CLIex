defmodule NatureRemoClient do
  @moduledoc """
  Documentation for `NatureRemoClient`.
  """

  import NatureRemoClient.CLI, only: [ run: 1 ]

  def main(argv) do
    parsed = run(argv)
    send_signal(parsed)
  end

  def send_signal({ :error, {}, _ }), do: {:error, "Bad arguments! ※example: remo -d aircon on"}
  def send_signal({ :device, { device, command, args }, _ }) do
    to_string = Atom.to_string(device) |> String.capitalize()
    String.to_existing_atom("Elixir.NatureRemoClient.Devices." <> to_string) |> apply(:execute, [command, args])
  end
end
