defmodule CowboyExample.ServerTest do
  use ExUnit.Case

  setup_all do
    Finch.start_link(name: CowboyExample.Finch)
    :ok
  end

  describe "GET /" do
    test "returns Hello World with 200" do
      {:ok, response} =
        :get
        |> Finch.build("http://localhost:4041")
        |> Finch.request(CowboyExample.Finch)

      assert response.body == "Hello World"
      assert response.status == 200
      assert {"content-type", "text/html"} in response.headers
    end

    test "returns `404 Not found` with 404" do
      {:ok, response} =
        :post
        |> Finch.build("http://localhost:4041/failure")
        |> Finch.request(CowboyExample.Finch)

      assert response.body == ""
      assert response.status == 404
      assert {"content-length", "0"} in response.headers
    end
  end

  describe "GET /greeting/:who" do
    test "returns Hello `:who` with 200" do
      {:ok, response} =
        :get
        |> Finch.build("http://localhost:4041/greet/Elixir")
        |> Finch.request(CowboyExample.Finch)

      assert response.body == "Hello Elixir"
      assert response.status == 200
      assert {"content-type", "text/html"} in response.headers
    end

    test "returns `greeting` `:who` with 200" do
      {:ok, response} =
        :get
        |> Finch.build("http://localhost:4041/greet/Elixir\?greeting=Hola")
        |> Finch.request(CowboyExample.Finch)

      assert response.body == "Hola Elixir"
      assert response.status == 200
      assert {"content-type", "text/html"} in response.headers
    end

    test "returns `404 Not found` with 404" do
      {:ok, response} =
        :post
        |> Finch.build("http://localhost:4041/greet/Elixir\?greeting=Hola")
        |> Finch.request(CowboyExample.Finch)

      assert response.body == "404 Not found"
      assert response.status == 404
      assert {"content-type", "text/html"} in response.headers
    end
  end

  describe "GET /static/:page" do
    test "returns index.html with 200" do
      {:ok, response} =
        :get
        |> Finch.build("http://localhost:4041/static/index.html")
        |> Finch.request(CowboyExample.Finch)

      assert response.body == "<h1>Hello World</h1>\n"
      assert response.status == 200
      assert {"content-type", "text/html"} in response.headers
    end
  end

end
