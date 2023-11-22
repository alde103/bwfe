defmodule GoldcrestTest do
  use ExUnit.Case
  doctest Goldcrest

  test "greets the world" do
    assert Goldcrest.hello() == :world
  end
end
