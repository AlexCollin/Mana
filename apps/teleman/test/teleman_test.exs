defmodule TelemanTest do
  use ExUnit.Case
  doctest Teleman

  test "greets the world" do
    assert Teleman.hello() == :world
  end
end
