defmodule NatureRemoClient.Devices.Aircon do
  def device_id, do: "cbe1b045-03e8-4c87-908c-af06520a5e48"

  def execute(:power_off, _), do: controller(:button, "power-off")
  def execute(:on, []), do: controller(:button, "")
  def execute(:on, ["night" | _]), do: api_helper("night")
  def execute(:set, ["mode", "summer" | _]), do: api_helper("operation_mode=cool&air_volume=auto&air_direction=auto&temperature=26")
  def execute(:set, ["mode", "auto" | _]), do: controller(:mode, "auto")
  def execute(:set, ["mode", "blow" | _]), do: controller(:mode, "blow")
  def execute(:set, ["mode", "cool" | _]), do: controller(:mode, "cool")
  def execute(:set, ["mode", "dry" | _]), do: controller(:mode, "dry")
  def execute(:set, ["mode", "warm" | _]), do: controller(:mode, "warm")
  def execute(:set, ["degree", n | _]), do: controller(:degree, n)

  defp controller(:button, button_name), do: api_helper("button=#{button_name}")
  defp controller(:mode, mode_name), do: api_helper("operation_mode=#{mode_name}")
  defp controller(:degree, degree_n), do: api_helper("temperature=#{degree_n}")
  defp api_helper(body_string) do
    NatureRemoClient.CustomClient.start
    NatureRemoClient.CustomClient.post("/1/appliances/#{device_id()}/aircon_settings", body_string)
  end
end
