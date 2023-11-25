defmodule CustomEngine do
  @behaviour EEx.Engine
  @delegate_to EEx.SmartEngine
  @impl true
  defdelegate init(opts), to: @delegate_to
  @impl true
  defdelegate handle_body(state), to: @delegate_to
  @impl true
  defdelegate handle_begin(state), to: @delegate_to
  @impl true

  defdelegate handle_end(state), to: @delegate_to
  @impl true
  defdelegate handle_text(state, meta, text),
    to: @delegate_to

  # @impl true
  # defdelegate handle_expr(state, marker, expr), to: @delegate_to

  @impl true
  def handle_expr(state, "|", expr) do
    expr =
      quote do
        IO.inspect(unquote(expr))
      end

    handle_expr(state, "", expr)
  end

  # General clause
  def handle_expr(state, marker, expr) do
    EEx.SmartEngine.handle_expr(state, marker, expr)
  end
end
