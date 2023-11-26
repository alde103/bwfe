defmodule ExampleServerHtmlEex.View do
  def render(conn, file, assigns) do
    Goldcrest.View.render(conn, file, assigns)
  end
end
