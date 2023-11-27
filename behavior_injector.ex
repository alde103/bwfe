defmodule BehaviorInjector do
  def behaviour_quoted_expr do
    quote do
      def hello, do: IO.puts("Hello world!")
    end
  end
end

defmodule TestSubject do
  Code.eval_quoted(BehaviorInjector.behaviour_quoted_expr(), [], __ENV__)
end

defmodule BehaviorInjector do
  defmacro define_hello do
    quote do
      def hello, do: IO.puts("Hello world!")
    end
  end
end

defmodule TestSubject do
  import BehaviorInjector
  define_hello()
end

defmodule BehaviorInjector do
  defmacro __using__(_options) do
    quote do
      def hello, do: IO.puts("Hello world!")
    end
  end
end

defmodule TestSubject do
  use BehaviorInjector
end

defmodule BehaviorInjector do
  defmacro __before_compile__(_options) do
    quote do
      def hello, do: IO.puts("Hello world!")
    end
  end
end

defmodule TestSubject do
  @before_compile BehaviorInjector
end

defmodule TestAfterCompile do
  @after_compile __MODULE__
  def __after_compile__(_env, _bytecode) do
    IO.puts("Compiled #{__MODULE__}")
  end
end

defmodule OnDef do
  def __on_definition__(_, _, name, _, _, body) do
    IO.puts("""
    Defining a function named #{name}
    with body:
    #{Macro.to_string(body)}
    """)
  end
end

defmodule TestOnDef do
  @on_definition OnDef
  def hello, do: IO.puts("world")
  def world, do: IO.puts("hello")
end
