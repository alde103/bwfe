opts = [
  scheme: :http,
  plug: ExampleServerHtmlEex.Router,
  options: [port: 4040]
]

%{start: {mod, fun, args}} = Plug.Cowboy.child_spec(opts)
apply(mod, fun, args)
