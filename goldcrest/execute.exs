Code.require_file("./support/example_fallback.ex")
Code.require_file("./support/example_controller.ex")
Code.require_file("./support/example_router.ex")

opts = [
  scheme: :http,
  plug: Goldcrest.ExampleRouter,
  options: [port: 4040]
]

%{start: {mod, fun, args}} = Plug.Cowboy.child_spec(opts)

apply(mod, fun, args)
