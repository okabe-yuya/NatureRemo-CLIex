defmodule NatureRemoClient.Devices.Light do
  def device_id, do: "76424031-fa6e-4461-bacb-5bdb17ae4a37"
  def scene_signal_id, do: "c30a4bf2-7467-4290-be20-a69366b5884d"

  def execute(:off, _), do: api_helper("off")
  def execute(:on, []), do: api_helper("on")
  def execute(:on, ["scene" | _]), do: scene_signal_id() |> signal_helper()
  def execute(:on, ["night" | _]), do: api_helper("night")
  def execute(_, _), do: { :error, nil }
  def api_helper(button_name) do
    NatureRemoClient.CustomClient.start
    NatureRemoClient.CustomClient.post("/1/appliances/#{device_id()}/light", "button=#{button_name}")
  end
  def signal_helper(signal_name) do
    NatureRemoClient.CustomClient.start
    NatureRemoClient.CustomClient.post("/1/signals/#{signal_name}/send", "")
  end
end
