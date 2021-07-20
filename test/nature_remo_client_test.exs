defmodule NatureRemoClientTest do
  use ExUnit.Case
  doctest NatureRemoClient

  test "greets the world" do
    assert NatureRemoClient.hello() == :world
  end
end
