defmodule NatureRemoClient.CLI do
  def run(argv), do: parse_args(argv)

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [d: :boolean], aliases: [ d: :device ])
    case parse do
      { [ device: device ], args, _ } -> { :device, to_pattern_match(device), args }
      _ -> { :error, {}, [] }
    end
  end

  def to_pattern_match(device) do
    [device_name, command | args] = String.split(device, " ")
    { String.to_atom(device_name), String.to_atom(command), args }
  end
end
