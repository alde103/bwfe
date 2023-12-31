defmodule Goldcrest.View do
  defmacro __using__(opts) do
    quote do
      alias Goldcrest.ResponseHelpers

      @opts unquote(opts)

      def __goldcrest_view_using_options__, do: @opts

      def render(conn, file, assigns) when is_binary(file) do
        ResponseHelpers.render(
          conn,
          file,
          %{
            assigns: assigns,
            opts: [
              functions: helper_functions()
            ]
          }
        )
      end

      def render(conn, type, data) do
        ResponseHelpers.render(conn, type, data)
      end

      defp helper_functions do
        [
          {
            __MODULE__,
            :functions
            |> __MODULE__.__info__()
            |> List.delete({:__goldcrest_view_using_options__, 0})
            |> List.delete({:render, 3})
          }
        ]
      end
    end
  end
end
