defmodule NatureRemoClient.CLITest do
  use ExUnit.Case
  doctest NatureRemoClient

  import NatureRemoClient.CLI, only: [ parse_args: 1 ]

  test "-d / aircon on" do
    parsed = parse_args(["-d", "aircon on"])
    { atom, val, _ } = parsed
    { device_name, command, args } = val

    assert atom == :device
    assert device_name == :aircon
    assert command == :on
    assert args == []
  end

  test "-d / aircon off" do
    parsed = parse_args(["-d", "aircon off"])
    { atom, val, _ } = parsed
    { device_name, command, args } = val

    assert atom == :device
    assert device_name == :aircon
    assert command == :off
    assert args == []
  end

  test "-d / aircon set degree 27" do
    parsed = parse_args(["-d", "aircon set degree 27"])
    { atom, val, _ } = parsed
    { device_name, command, args } = val
    [ d, degree ] = args

    assert atom == :device
    assert device_name == :aircon
    assert command == :set
    assert args != []
    assert length(args) == 2
    assert d == "degree"
    assert degree = "27"
  end

  test "-d / aircon set mode cool" do
    parsed = parse_args(["-d", "aircon set mode cool"])
    { atom, val, _ } = parsed
    { device_name, command, args } = val
    [ m, mode ] = args

    assert atom == :device
    assert device_name == :aircon
    assert command == :set
    assert args != []
    assert length(args) == 2
    assert m == "mode"
    assert mode = "cool"
  end

  test "-d / light on" do
    parsed = parse_args(["-d", "light on"])
    { atom, val, _ } = parsed
    { device_name, command, args } = val

    assert atom == :device
    assert device_name == :light
    assert command == :on
    assert args == []
  end

  test "-d / light off" do
    parsed = parse_args(["-d", "light off"])
    { atom, val, _ } = parsed
    { device_name, command, args } = val

    assert atom == :device
    assert device_name == :light
    assert command == :off
    assert args == []
  end

  test "-d / light set night" do
    parsed = parse_args(["-d", "light set night"])
    { atom, val, _ } = parsed
    { device_name, command, args } = val

    assert atom == :device
    assert device_name == :light
    assert command == :set
    assert length(args) == 1
    assert Enum.at(args, 0) == "night"
  end

  test "-d / light set scene" do
    parsed = parse_args(["-d", "light set scene"])
    { atom, val, _ } = parsed
    { device_name, command, args } = val

    assert atom == :device
    assert device_name == :light
    assert command == :set
    assert length(args) == 1
    assert Enum.at(args, 0) == "scene"
  end

  test "-dオプションが渡されない" do
    parsed = parse_args(["-c", "light set scene"])
    { command, val, _ } = parsed

    assert command == :error
    assert val == {}
  end

  test "オプションなし" do
    parsed = parse_args(["light set scene"])
    { command, val, _ } = parsed

    assert command == :error
    assert val == {}
  end

  test "引数なし" do
    parsed = parse_args([])
    { command, val, _ } = parsed

    assert command == :error
    assert val == {}
  end
end
