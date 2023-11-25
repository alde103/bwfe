defmodule ExampleServerHtmlEexTest do
  use ExUnit.Case
  doctest ExampleServerHtmlEex

  test "greets the world" do
    assert ExampleServerHtmlEex.hello() == :world
  end
end
