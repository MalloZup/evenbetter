defmodule EvenbetterTest do
  use ExUnit.Case
  doctest Evenbetter

  test "greets the world" do
    assert Evenbetter.hello() == :world
  end
end
